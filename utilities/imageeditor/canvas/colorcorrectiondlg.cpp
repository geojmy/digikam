/* ============================================================
 * Author: Gilles Caulier <caulier dot gilles at kdemail dot net>
 * Date  : 2006-05-15
 * Description : a dialog to see preview ICC color correction 
 *               before to apply color profile.
 * 
 * Copyright 2006 by Gilles Caulier
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

// Qt includes.

#include <qlabel.h>
#include <qwhatsthis.h>
#include <qlayout.h>
#include <qframe.h>
#include <qstring.h>

// KDE includes.

#include <kdebug.h>
#include <klocale.h>
#include <kiconloader.h>
#include <kapplication.h>

// Local includes.

#include "dimg.h"
#include "icctransform.h"
#include "colorcorrectiondlg.h"

namespace Digikam
{

ColorCorrectionDlg::ColorCorrectionDlg(QWidget* parent, DImg *preview, 
                                       IccTransform *iccTrans, const QString& msg)
                  : KDialogBase(Plain, i18n("Applying Workspace Color Profile"), Help|Ok|Cancel, Ok,
                                parent, 0, true, true)
{
    setHelp("iccprofile.anchor", "digikam");
    setButtonText(Ok, i18n("Apply Profile"));
    setButtonText(Cancel, i18n("Do Nothing"));
    
    QGridLayout* grid = new QGridLayout( plainPage(), 4, 1, 0, KDialog::spacingHint());
        
    QLabel *originalTitle   = new QLabel(i18n("Original Picture:"), plainPage());
    QLabel *previewOriginal = new QLabel(plainPage());
    QLabel *targetTitle     = new QLabel(i18n("Corrected Picture:"), plainPage());
    QLabel *previewTarget   = new QLabel(plainPage());
    QLabel *logo            = new QLabel(plainPage());
    QLabel *message         = new QLabel(msg, plainPage());
    
    previewOriginal->setPixmap(preview->convertToPixmap());
    previewTarget->setPixmap(preview->convertToPixmap(iccTrans));
    KIconLoader* iconLoader = KApplication::kApplication()->iconLoader();
    logo->setPixmap(iconLoader->loadIcon("digikam", KIcon::NoGroup, 128, KIcon::DefaultState, 0, true));    
    
    grid->addMultiCellWidget(originalTitle, 0, 0, 0, 0);
    grid->addMultiCellWidget(previewOriginal, 1, 2, 0, 0);
    grid->addMultiCellWidget(targetTitle, 3, 3, 0, 0);
    grid->addMultiCellWidget(previewTarget, 4, 4, 0, 0);
    grid->addMultiCellWidget(logo, 1, 1, 1, 1);
    grid->addMultiCellWidget(message, 2, 4, 1, 1);
}

ColorCorrectionDlg::~ColorCorrectionDlg()
{
}

}  // NameSpace Digikam

