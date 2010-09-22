/* ============================================================
 *
 * This file is a part of digiKam project
 * http://www.digikam.org
 *
 * Date        : 2010-09-03
 * Description : Integrated, multithread face detection / recognition
 *
 * Copyright (C) 2010 by Marcel Wiesweg <marcel dot wiesweg at gmx dot de>
 *
 * This program is free software; you can redistribute it
 * and/or modify it under the terms of the GNU General
 * Public License as published by the Free Software Foundation;
 * either version 2, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * ============================================================ */

#include "facepipeline.h"

// Qt includes

#include <QExplicitlySharedDataPointer>
#include <QMetaMethod>
#include <QMutex>
#include <QSharedData>
#include <QWaitCondition>

// KDE includes

// libkface includes

#include <libkface/facedetector.h>
#include <libkface/recognitiondatabase.h>

// Local includes

#include "faceiface.h"
#include "previewloadthread.h"
#include "workerobject.h"

namespace Digikam
{

class FacePipelineExtendedPackage : public FacePipelinePackage, public QSharedData
{
public:

    QString filePath;
    DImg    detectionImage; // image scaled to about 0.5 Mpx

    bool operator==(const LoadingDescription& description) const
    {
        return filePath == description.filePath;
    }

    typedef QExplicitlySharedDataPointer<FacePipelineExtendedPackage> Ptr;
};

// ----------------------------------------------------------------------------------------

class ParallelPipes : public QObject
{
    Q_OBJECT

public:

    ParallelPipes();
    ~ParallelPipes();

    void schedule();
    void deactivate(WorkerObject::DeactivatingMode mode = WorkerObject::FlushSignals);

    void add(WorkerObject* worker);

    QList<WorkerObject*> m_workers;

public Q_SLOTS:

    void process(FacePipelineExtendedPackage::Ptr package);

Q_SIGNALS:

    void processed(FacePipelineExtendedPackage::Ptr package);

protected:

    QList<QMetaMethod> m_methods;
    int                m_currentIndex;
};

// ----------------------------------------------------------------------------------------

class ScanStateFilter : public DynamicThread
{
    Q_OBJECT

public:

    ScanStateFilter(FacePipeline::FilterMode mode, FacePipeline::FacePipelinePriv* d);

    void process(const QList<ImageInfo>& infos);
    void process(const ImageInfo& info);

    /**
     * Returns true if the info is accepted for further processing.
     * In this case, database records may be changed.
     * Returns false if the info shall be skipped.
     */
    bool filter(const ImageInfo& info);

public:

    FacePipeline::FacePipelinePriv* const d;
    FacePipeline::FilterMode              mode;

protected Q_SLOTS:

    void dispatch();

Q_SIGNALS:

    void infosToDispatch();

protected:

    virtual void run();

    QList<ImageInfo> toFilter;
    QList<ImageInfo> toSend;
    QList<ImageInfo> toBeSkipped;
};

// ----------------------------------------------------------------------------------------

class PreviewLoader : public PreviewLoadThread
{
    Q_OBJECT

public:

    PreviewLoader(FacePipeline::FacePipelinePriv* d);

    void cancel();
    bool sentOutLimitReached();
    void checkRestart();

public Q_SLOTS:

    void process(FacePipelineExtendedPackage::Ptr package);
    void slotImageLoaded(const LoadingDescription& loadingDescription, const DImg& img);

Q_SIGNALS:

    void processed(FacePipelineExtendedPackage::Ptr package);

protected:

    QList<FacePipelineExtendedPackage::Ptr> scheduledPackages;
    int                                     maximumSentOutPackages;

    FacePipeline::FacePipelinePriv* const   d;
};

// ----------------------------------------------------------------------------------------

class DetectionWorker : public WorkerObject
{
    Q_OBJECT

public:

    DetectionWorker(FacePipeline::FacePipelinePriv* d);

public Q_SLOTS:

    void process(FacePipelineExtendedPackage::Ptr package);
    void setAccuracy(int accuracy);

Q_SIGNALS:

    void processed(FacePipelineExtendedPackage::Ptr package);

protected:

    KFaceIface::FaceDetector              detector;
    FacePipeline::FacePipelinePriv* const d;
};

// ----------------------------------------------------------------------------------------

class RecognitionWorker : public WorkerObject
{
    Q_OBJECT

public:

    RecognitionWorker(FacePipeline::FacePipelinePriv* d);

public Q_SLOTS:

    void process(FacePipelineExtendedPackage::Ptr package);
    void setThreshold(double threshold);

Q_SIGNALS:

    void processed(FacePipelineExtendedPackage::Ptr package);

protected:

    KFaceIface::RecognitionDatabase       database;
    double                                recognitionThreshold;
    FacePipeline::FacePipelinePriv* const d;
};

// ----------------------------------------------------------------------------------------

class DatabaseWriter : public QObject
{
    Q_OBJECT

public:

    DatabaseWriter(FacePipeline::FacePipelinePriv* d);

public Q_SLOTS:

    void process(FacePipelineExtendedPackage::Ptr package);

Q_SIGNALS:

    void processed(FacePipelineExtendedPackage::Ptr package);

protected:

    FacePipeline::FacePipelinePriv* const d;
};

// ----------------------------------------------------------------------------------------

class FacePipeline::FacePipelinePriv : public QObject
{
    Q_OBJECT

public:

    FacePipelinePriv(FacePipeline* q);

    void processBatch(const QList<ImageInfo>& infos);
    void sendFromFilter(const QList<ImageInfo>& infos);
    void skipFromFilter(const QList<ImageInfo>& infosForSkipping);
    void send(FacePipelineExtendedPackage::Ptr package);
    FacePipelineExtendedPackage::Ptr buildPackage(const ImageInfo& info);

    bool hasFinished();
    void checkFinished();
    void start();
    void stop();

public:

    ScanStateFilter*   alreadyScannedFilter;
    PreviewLoader*     previewThread;
    DetectionWorker*   detectionWorker;
    ParallelPipes*     parallelDetectors;
    RecognitionWorker* recognitionWorker;
    DatabaseWriter*    databaseWriter;

    FaceIface         *iface;
    bool               started;
    int                infosForFiltering;
    int                packagesOnTheRoad;

public Q_SLOTS:

    void finishProcess(FacePipelineExtendedPackage::Ptr package);

Q_SIGNALS:

    friend class FacePipeline;
    void startProcess(FacePipelineExtendedPackage::Ptr package);

    void accuracyChanged(int accuracy);
    void thresholdChanged(double threshold);

private:

    FacePipeline* const q;
};

} // namespace Digikam
