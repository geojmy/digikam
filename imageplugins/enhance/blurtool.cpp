/* ============================================================
 *
 * This file is a part of digiKam project
 * http://www.digikam.org
 *
 * Date        : 2004-07-09
 * Description : a tool to blur an image
 *
 * Copyright (C) 2004-2010 by Gilles Caulier <caulier dot gilles at gmail dot com>
 * Copyright (C) 2009      by Andi Clemens <andi dot clemens at gmail dot com>
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

#include "blurtool.moc"

// Qt includes

#include <QGridLayout>
#include <QLabel>

// KDE includes

#include <kaboutdata.h>
#include <kapplication.h>
#include <kconfig.h>
#include <kconfiggroup.h>
#include <kcursor.h>
#include <kglobal.h>
#include <kiconloader.h>
#include <klocale.h>

// LibKDcraw includes

#include <libkdcraw/rnuminput.h>

// Local includes

#include "blurfilter.h"
#include "editortoolsettings.h"
#include "imageiface.h"
#include "imageregionwidget.h"

using namespace KDcrawIface;

namespace DigikamEnhanceImagePlugin
{

class BlurTool::BlurToolPriv
{
public:

    BlurToolPriv() :
        radiusInput(0),
        previewWidget(0),
        gboxSettings(0)
    {}

    static const QString configGroupName;
    static const QString configRadiusAdjustmentEntry;

    RIntNumInput*        radiusInput;
    ImageRegionWidget*   previewWidget;
    EditorToolSettings*  gboxSettings;
};
const QString BlurTool::BlurToolPriv::configGroupName("gaussianblur Tool");
const QString BlurTool::BlurToolPriv::configRadiusAdjustmentEntry("RadiusAdjustment");

// --------------------------------------------------------

BlurTool::BlurTool(QObject* parent)
    : EditorToolThreaded(parent),
      d(new BlurToolPriv)
{
    setObjectName("gaussianblur");
    setToolName(i18n("Blur"));
    setToolIcon(SmallIcon("blurimage"));
    setToolHelp("blursharpentool.anchor");

    d->gboxSettings  = new EditorToolSettings;
    d->previewWidget = new ImageRegionWidget;

    // --------------------------------------------------------

    QLabel* label  = new QLabel(i18n("Smoothness:"));
    d->radiusInput = new RIntNumInput();
    d->radiusInput->setRange(0, 100, 1);
    d->radiusInput->setDefaultValue(0);
    d->radiusInput->setWhatsThis(i18n("A smoothness of 0 has no effect, "
                                      "1 and above determine the Gaussian blur matrix radius "
                                      "that determines how much to blur the image."));

    // --------------------------------------------------------

    QGridLayout* grid = new QGridLayout( );
    grid->addWidget(label,          0, 0, 1, 2);
    grid->addWidget(d->radiusInput, 1, 0, 1, 2);
    grid->setRowStretch(2, 10);
    grid->setMargin(d->gboxSettings->spacingHint());
    grid->setSpacing(d->gboxSettings->spacingHint());
    d->gboxSettings->plainPage()->setLayout(grid);

    // --------------------------------------------------------

    setPreviewModeMask(PreviewToolBar::AllPreviewModes);
    setToolSettings(d->gboxSettings);
    setToolView(d->previewWidget);
    init();

    // --------------------------------------------------------

    connect(d->radiusInput, SIGNAL(valueChanged(int)),
            this, SLOT(slotTimer()));

    connect(d->previewWidget, SIGNAL(signalOriginalClipFocusChanged()),
            this, SLOT(slotTimer()));
}

BlurTool::~BlurTool()
{
    delete d;
}

void BlurTool::readSettings()
{
    KSharedConfig::Ptr config = KGlobal::config();
    KConfigGroup group        = config->group(d->configGroupName);
    d->radiusInput->setValue(group.readEntry(d->configRadiusAdjustmentEntry, d->radiusInput->defaultValue()));
}

void BlurTool::writeSettings()
{
    KSharedConfig::Ptr config = KGlobal::config();
    KConfigGroup group        = config->group(d->configGroupName);
    group.writeEntry(d->configRadiusAdjustmentEntry, d->radiusInput->value());
    config->sync();
}

void BlurTool::slotResetSettings()
{
    d->radiusInput->blockSignals(true);
    d->radiusInput->slotReset();
    d->radiusInput->blockSignals(false);
}

void BlurTool::prepareEffect()
{
    DImg img = d->previewWidget->getOriginalRegionImage();
    setFilter(new BlurFilter(&img, this, d->radiusInput->value()));
}

void BlurTool::putPreviewData()
{
    DImg preview = filter()->getTargetImage();
    d->previewWidget->setPreviewImage(preview);
}

void BlurTool::prepareFinal()
{
    ImageIface iface(0, 0);
    setFilter(new BlurFilter(iface.getOriginal(), this, d->radiusInput->value()));
}

void BlurTool::putFinalData()
{
    ImageIface iface(0, 0);
    iface.putOriginal(i18n("Gaussian Blur"), filter()->filterAction(), filter()->getTargetImage());
}

}  // namespace DigikamEnhanceImagePlugin
