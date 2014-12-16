/* ============================================================
 *
 * This file is a part of digiKam project
 * http://www.digikam.org
 *
 * Date        : 2010-02-27
 * Description : White Balance batch tool.
 *
 * Copyright (C) 2010-2014 by Gilles Caulier <caulier dot gilles at gmail dot com>
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

#include "whitebalance.moc"

// Qt includes

#include <QWidget>

// KDE includes

#include <KLocalizedString>
#include <kstandarddirs.h>
#include <kglobal.h>

// Local includes

#include "dimg.h"
#include "wbfilter.h"
#include "wbsettings.h"

namespace Digikam
{

WhiteBalance::WhiteBalance(QObject* const parent)
    : BatchTool("WhiteBalance", ColorTool, parent)
{
    m_settingsView = 0;

    setToolTitle(i18n("White Balance"));
    setToolDescription(i18n("Adjust White Balance."));
    setToolIconName("whitebalance");
}

WhiteBalance::~WhiteBalance()
{
}

void WhiteBalance::registerSettingsWidget()
{
    m_settingsWidget = new QWidget;
    m_settingsView   = new WBSettings(m_settingsWidget);
    m_settingsView->showAdvancedButtons(false);

    connect(m_settingsView, SIGNAL(signalSettingsChanged()),
            this, SLOT(slotSettingsChanged()));

    BatchTool::registerSettingsWidget();
}

BatchToolSettings WhiteBalance::defaultSettings()
{
    BatchToolSettings prm;
    WBContainer defaultPrm = m_settingsView->defaultSettings();

    prm.insert("black",          (double)defaultPrm.black);
    prm.insert("temperature",    (double)defaultPrm.temperature);
    prm.insert("green",          (double)defaultPrm.green);
    prm.insert("dark",           (double)defaultPrm.dark);
    prm.insert("gamma",          (double)defaultPrm.gamma);
    prm.insert("saturation",     (double)defaultPrm.saturation);
    prm.insert("expositionMain", (double)defaultPrm.expositionMain);
    prm.insert("expositionFine", (double)defaultPrm.expositionFine);

    return prm;
}

void WhiteBalance::slotAssignSettings2Widget()
{
    WBContainer prm;

    prm.black          = settings()["black"].toDouble();
    prm.temperature    = settings()["temperature"].toDouble();
    prm.green          = settings()["green"].toDouble();
    prm.dark           = settings()["dark"].toDouble();
    prm.gamma          = settings()["gamma"].toDouble();
    prm.saturation     = settings()["saturation"].toDouble();
    prm.expositionMain = settings()["expositionMain"].toDouble();
    prm.expositionFine = settings()["expositionFine"].toDouble();

    m_settingsView->setSettings(prm);
}

void WhiteBalance::slotSettingsChanged()
{
    BatchToolSettings prm;
    WBContainer currentPrm = m_settingsView->settings();

    prm.insert("black",          (double)currentPrm.black);
    prm.insert("temperature",    (double)currentPrm.temperature);
    prm.insert("green",          (double)currentPrm.green);
    prm.insert("dark",           (double)currentPrm.dark);
    prm.insert("gamma",          (double)currentPrm.gamma);
    prm.insert("saturation",     (double)currentPrm.saturation);
    prm.insert("expositionMain", (double)currentPrm.expositionMain);
    prm.insert("expositionFine", (double)currentPrm.expositionFine);

    BatchTool::slotSettingsChanged(prm);
}

bool WhiteBalance::toolOperations()
{
    if (!loadToDImg())
    {
        return false;
    }

    WBContainer prm;

    prm.black          = settings()["black"].toDouble();
    prm.temperature    = settings()["temperature"].toDouble();
    prm.green          = settings()["green"].toDouble();
    prm.dark           = settings()["dark"].toDouble();
    prm.gamma          = settings()["gamma"].toDouble();
    prm.saturation     = settings()["saturation"].toDouble();
    prm.expositionMain = settings()["expositionMain"].toDouble();
    prm.expositionFine = settings()["expositionFine"].toDouble();

    WBFilter wb(&image(), 0L, prm);
    applyFilter(&wb);

    return (savefromDImg());
}

}  // namespace Digikam
