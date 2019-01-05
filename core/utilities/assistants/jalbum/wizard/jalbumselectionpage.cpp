/* ============================================================
 *
 * This file is a part of digiKam project
 * http://www.digikam.org
 *
 * Date        : 2006-04-04
 * Description : a tool to generate jAlbum image galleries
 *
 * Copyright (C) 2013-2019 by Andrew Goodbody <ajg zero two at elfringham dot co dot uk>
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

#include "jalbumselectionpage.h"

// Qt includes

#include <QIcon>
#include <QPixmap>
#include <QStackedWidget>

// Local includes

#include "jalbumwizard.h"
#include "jalbuminfo.h"
#include "ditemslist.h"

namespace Digikam
{

class Q_DECL_HIDDEN JAlbumSelectionPage::Private
{
public:

    explicit Private(QWizard* const dialog)
      : albumSupport(false),
        albumSelector(0),
        imageList(0),
        stack(0),
        wizard(0),
        info(0),
        iface(0)
    {
        wizard = dynamic_cast<JAlbumWizard*>(dialog);

        if (wizard)
        {
            info  = wizard->jalbumInfo();
            iface = info->m_iface;
        }
    }

    bool            albumSupport;
    QWidget*        albumSelector;
    DItemsList*     imageList;
    QStackedWidget* stack;
    JAlbumWizard*   wizard;
    JAlbumInfo*     info;
    DInfoInterface* iface;
};

JAlbumSelectionPage::JAlbumSelectionPage(QWizard* const dialog, const QString& title)
    : DWizardPage(dialog, title),
      d(new Private(dialog))
{
    setObjectName(QLatin1String("AlbumSelectorPage"));

    d->stack              = new QStackedWidget(this);
    d->albumSupport       = (d->iface && d->iface->supportAlbums());

    if (d->albumSupport)
    {
        d->albumSelector = d->iface->albumChooser(this);
    }
    else
    {
        d->albumSelector = new QWidget(this);
    }

    d->stack->insertWidget(JAlbumInfo::ALBUMS, d->albumSelector);

    d->imageList          = new DItemsList(this);
    d->imageList->setControlButtonsPlacement(DItemsList::ControlButtonsBelow);
    d->stack->insertWidget(JAlbumInfo::IMAGES, d->imageList);

    setPageWidget(d->stack);
    setLeftBottomPix(QIcon::fromTheme(QLatin1String("folder-pictures")));

    if (d->albumSupport)
    {
        connect(d->iface, SIGNAL(signalAlbumChooserSelectionChanged()),
                this, SIGNAL(completeChanged()));
    }

    connect(d->imageList, SIGNAL(signalImageListChanged()),
            this, SIGNAL(completeChanged()));
}

JAlbumSelectionPage::~JAlbumSelectionPage()
{
    delete d;
}


void JAlbumSelectionPage::setItemsList(const QList<QUrl>& urls)
{
    d->imageList->slotAddImages(urls);
}

void JAlbumSelectionPage::initializePage()
{
    d->imageList->setIface(d->iface);

    if (d->info->m_getOption == JAlbumInfo::IMAGES)
    {
        d->imageList->loadImagesFromCurrentSelection();
    }

    d->stack->setCurrentIndex(d->info->m_getOption);
}

bool JAlbumSelectionPage::validatePage()
{
    if (d->stack->currentIndex() == JAlbumInfo::ALBUMS)
    {
        if (d->albumSupport)
        {
            if (d->iface->albumChooserItems().isEmpty())
                return false;

            d->info->m_albumList = d->iface->albumChooserItems();
        }
        else
        {
            return false;
        }
    }
    else
    {
        if (d->imageList->imageUrls().isEmpty())
            return false;

        d->info->m_imageList = d->imageList->imageUrls();
    }

    return true;
}

bool JAlbumSelectionPage::isComplete() const
{
    if (d->stack->currentIndex() == JAlbumInfo::ALBUMS)
    {
        if (!d->albumSupport)
            return false;

        return (!d->iface->albumChooserItems().isEmpty());
    }

    return (!d->imageList->imageUrls().isEmpty());
}

} // namespace Digikam
