/* ============================================================
 * File  : imageplugin_charcoal.cpp
 * Author: Gilles Caulier <caulier dot gilles at free.fr>
 * Date  : 2004-08-26
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

// Local includes.

#include "imageeffect_charcoal.h"
#include "imageplugin_charcoal.h"

K_EXPORT_COMPONENT_FACTORY( digikamimageplugin_charcoal,
                            KGenericFactory<ImagePlugin_Charcoal>("digikamimageplugin_charcoal"));

ImagePlugin_Charcoal::ImagePlugin_Charcoal(QObject *parent, const char*,
                                                   const QStringList &)
                    : Digikam::ImagePlugin(parent, "ImagePlugin_Charcoal")
{
    new KAction(i18n("Charcoal Drawing..."), 0, 
                this, SLOT(slotCharcoal()),
                actionCollection(), "imageplugin_charcoal");
                
    
    kdDebug() << "ImagePlugin_Charcoal plugin loaded" << endl;
}

ImagePlugin_Charcoal::~ImagePlugin_Charcoal()
{
}

QStringList ImagePlugin_Charcoal::guiDefinition() const
{
    QStringList guiDef;
    guiDef.append("MenuBar/Menu/Fi&lters/Generic/Action/imageplugin_charcoal/ ");
    return guiDef;
}

void ImagePlugin_Charcoal::slotCharcoal()
{
    DigikamCharcoalImagesPlugin::ImageEffect_Charcoal dlg(parentWidget());
    dlg.exec();
}


#include "imageplugin_charcoal.moc"
