/* ============================================================
 * File  : album.cpp
 * Author: Renchi Raju <renchi@pooh.tam.uiuc.edu>
 * Date  : 2004-06-15
 * Description : 
 * 
 * Copyright 2004 by Renchi Raju

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

#include <kdebug.h>
#include <kapplication.h>
#include <kglobal.h>
#include <kiconloader.h>
#include <kfileitem.h>

#include "albummanager.h"
#include "albumdb.h"
#include "album.h"

Album::Album(Album::Type type, int id, const QString& title, bool root)
{
    m_parent = 0;
    m_next   = 0;
    m_prev   = 0;
    m_firstChild = 0;
    m_lastChild  = 0;
    m_clearing   = false;

    m_type  = type;
    m_id    = id;
    m_title = title;
    m_root  = root;
    m_url   = root ? "/" : ""; 

    m_viewItem = 0;
}

Album::~Album()
{
    if (m_parent)
        m_parent->removeChild(this);
    clear();
}

void Album::setParent(Album* parent)
{
    if (parent)
    {
        m_parent = parent;
        parent->insertChild(this);
        if (!parent->isRoot())
            m_url = parent->m_url + "/" + m_title;
        else
            m_url = parent->m_url + m_title;
    }
    else
    {
        m_url = "";
    }
}

Album* Album::getParent() const
{
    return m_parent;
}

Album* Album::firstChild() const
{
    return m_firstChild;    
}

Album* Album::lastChild() const
{
    return m_lastChild;
}

Album* Album::next() const
{
    return m_next;    
}

Album* Album::prev() const
{
    return m_prev;
}

void Album::insertChild(Album* child)
{
    if (!child)
        return;

    if (!m_firstChild)
    {
        m_firstChild = child;
        m_lastChild  = child;
        child->m_next = 0;
        child->m_prev = 0;
    }
    else
    {
        m_lastChild->m_next = child;
        child->m_prev  = m_lastChild;
        child->m_next  = 0;
        m_lastChild    = child;
    }
}

void Album::removeChild(Album* child)
{
    if (!child || m_clearing)
        return;

    if (child == m_firstChild)
    {
        m_firstChild = m_firstChild->m_next;
        if (m_firstChild)
            m_firstChild->m_prev = 0;
        else
            m_firstChild = m_lastChild = 0;
    }
    else if (child == m_lastChild)
    {
        m_lastChild = m_lastChild->m_prev;
        if (m_lastChild)
            m_lastChild->m_next = 0;
        else
            m_firstChild = m_lastChild = 0;
    }
    else
    {
        Album* c = child;
        if (c->m_prev)
            c->m_prev->m_next = c->m_next;
        if (c->m_next)
            c->m_next->m_prev = c->m_prev;
    }
}

void Album::clear()
{
    m_clearing = true;
        
    Album* child = m_firstChild;
    Album* nextChild;
    while (child)
    {
        nextChild = child->m_next;
        delete child;
        child = nextChild;
    }

    m_firstChild = 0;
    m_lastChild  = 0;

    m_clearing = false;
}

void Album::setID(int id)
{
    m_id = id;
}

int Album::getID() const
{
    return m_id;
}

void Album::setTitle(const QString& title)
{
    m_title = title;
}

QString Album::getTitle() const
{
    return m_title;
}

QString Album::getURL() const
{
    return m_url;    
}

Album::Type Album::type() const
{
    return m_type;
}

void Album::setViewItem(void *viewItem)
{
    m_viewItem = viewItem;    
}

void* Album::getViewItem() const
{
    return m_viewItem;
}

bool Album::isRoot() const
{
    return m_root;
}

void Album::setIcon(const QString& icon)
{
    m_icon = icon;    
}

QString Album::getIcon() const
{
    return m_icon;    
}

// ------------------------------------------------------------------------------

PAlbum::PAlbum(KFileItem* fileItem, const QString& title, int id,  bool root)
    : Album(Album::PHYSICAL, id, title, root)
{
    m_fileItem   = fileItem;
    m_caption    = "";
    m_collection = "";
    m_date = QDate::currentDate();
}

PAlbum::~PAlbum()
{
    
}

void PAlbum::setCaption(const QString& caption, bool addToDB)
{
    m_caption = caption;    
    if (addToDB)
    {
        AlbumDB* db = AlbumManager::instance()->albumDB();
        db->setCaption(this);
    }
}

void PAlbum::setCollection(const QString& collection, bool addToDB)
{
    m_collection = collection;
    if (addToDB)
    {
        AlbumDB* db = AlbumManager::instance()->albumDB();
        db->setCollection(this);
    }
}

void PAlbum::setDate(const QDate& date, bool addToDB)
{
    m_date = date;
    if (addToDB)
    {
        AlbumDB* db = AlbumManager::instance()->albumDB();
        db->setDate(this);
    }
}

QString PAlbum::getCaption() const
{
    return m_caption;
}

QString PAlbum::getCollection() const
{
    return m_collection;
}

QDate PAlbum::getDate() const
{
    return m_date;
}

KURL PAlbum::getKURL() const
{
    return m_fileItem->url();
}

KFileItem* PAlbum::fileItem() const
{
    return m_fileItem;    
}

// --------------------------------------------------------------------------

TAlbum::TAlbum(const QString& title, int id, bool root)
    : Album(Album::TAG, id, title, root),
      m_pid(-1)
{
}

TAlbum::~TAlbum()
{
}

void TAlbum::setPID(int id)
{
    m_pid = id;    
}

int TAlbum::getPID() const
{
    return m_pid;
}

QString TAlbum::getURL() const
{
    QString url("");
    if (!isRoot() && getParent())
    {
        url = getParent()->getURL();
        if (!url.endsWith("/"))
            url += "/";
    }
    url += m_title;
    return url;
}

QPixmap TAlbum::getPixmap() const
{
    KIconLoader *iconLoader = KApplication::kApplication()->iconLoader();

    QPixmap pix;
    
    if (!isRoot())
        pix = iconLoader->loadIcon(m_icon, KIcon::NoGroup, 20,
                                   KIcon::DefaultState, 0, true);
    else
        pix = iconLoader->loadIcon("tag-folder", KIcon::NoGroup, 20,
                                   KIcon::DefaultState, 0, true);

    return pix;
}
