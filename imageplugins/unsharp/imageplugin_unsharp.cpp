/* ============================================================
 * File  : imageplugin_unsharp.h
 * Author: Gilles Caulier <caulier dot gilles at free.fr>
 * Date  : 2004-08-27
 * Description : 
 * 
 * Copyright 2004 by Gilles Caulier
 *
 * This program is free software; you can redistribute it
 * and/or modify it under the terms of the GNU General
 * Public License as published bythe Free Software Foundation;
 * either version 2, or (at your option)
 * any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * ============================================================ */

// KDE includes.
  
#include <klocale.h>
#include <kgenericfactory.h>
#include <klibloader.h>
#include <kaction.h>
#include <kcursor.h>
#include <kdebug.h>

// Digikam includes.

#include <digikam/imageiface.h>

// Local includes.

#include "unsharp.h"
#include "imageplugin_unsharp.h"

K_EXPORT_COMPONENT_FACTORY( digikamimageplugin_unsharp,
                            KGenericFactory<ImagePlugin_Unsharp>("digikamimageplugin_unsharp"));

ImagePlugin_Unsharp::ImagePlugin_Unsharp(QObject *parent, const char*,
                                             const QStringList &)
                   : Digikam::ImagePlugin(parent, "ImagePlugin_Unsharp")
{
    new KAction(i18n("Unsharped Mask..."), 0, 
                this, SLOT(slotUnsharp()),
                actionCollection(), "imageplugin_unsharp");

    kdDebug() << "ImagePlugin_Unsharp plugin loaded" << endl;
}

ImagePlugin_Unsharp::~ImagePlugin_Unsharp()
{
}

QStringList ImagePlugin_Unsharp::guiDefinition() const
{
    QStringList guiDef;
    guiDef.append("MenuBar/Menu/Fi&x/Fix/Action/imageplugin_unsharp/ ");
    return guiDef;
}

void ImagePlugin_Unsharp::slotUnsharp()
{
    DigikamUnsharpFilterImagesPlugin::UnsharpDialog dlg(parentWidget());
    dlg.exec();
}


#include "imageplugin_unsharp.moc"
