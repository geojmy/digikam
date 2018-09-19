/* ============================================================
 *
 * This file is a part of digiKam project
 * http://www.digikam.org
 *
 * Date        : 2012-12-31
 * Description : time adjust actions using threads.
 *
 * Copyright (C) 2012      by Smit Mehta <smit dot meh at gmail dot com>
 * Copyright (C) 2006-2018 by Gilles Caulier <caulier dot gilles at gmail dot com>
 * Copyright (c) 2018      by Maik Qualmann <metzpinguin at gmail dot com>
 *
 * This program is free software; you can redistribute it
 * and/or modify it under the terms of the GNU General
 * Public License as published by the Free Software Foundation;
 * either version 2, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * ============================================================ */

#ifndef DIGIKAM_TIME_ADJUST_TASK_H
#define DIGIKAM_TIME_ADJUST_TASK_H

// Qt includes

#include <QUrl>

// Local includes

#include "actionthreadbase.h"
#include "timeadjustcontainer.h"

namespace Digikam
{

class TimeAdjustTask : public ActionJob
{
    Q_OBJECT

public:

    explicit TimeAdjustTask(const QUrl& url);
    ~TimeAdjustTask();

    void setSettings(const TimeAdjustContainer& settings);
    void setItemsMap(QMap<QUrl, QDateTime> itemsMap);

Q_SIGNALS:

    void signalProcessStarted(const QUrl&);
    void signalProcessEnded(const QUrl&, int);

protected:

    void run();

private:

    class Private;
    Private* const d;
};

}  // namespace Digikam

#endif // DIGIKAM_TIME_ADJUST_TASK