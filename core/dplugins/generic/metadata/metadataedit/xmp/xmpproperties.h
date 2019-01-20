/* ============================================================
 *
 * This file is a part of digiKam project
 * https://www.digikam.org
 *
 * Date        : 2007-10-24
 * Description : XMP workflow status properties settings page.
 *
 * Copyright (C) 2007-2019 by Gilles Caulier <caulier dot gilles at gmail dot com>
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

#ifndef DIGIKAM_XMP_PROPERTIES_H
#define DIGIKAM_XMP_PROPERTIES_H

// Qt includes

#include <QWidget>
#include <QByteArray>

namespace Digikam
{

class XMPProperties : public QWidget
{
    Q_OBJECT

public:

    explicit XMPProperties(QWidget* const parent);
    ~XMPProperties();

    void applyMetadata(QByteArray& xmpData);
    void readMetadata(QByteArray& xmpData);

Q_SIGNALS:

    void signalModified();

private:

    class Private;
    Private* const d;
};

} // namespace Digikam

#endif // DIGIKAM_XMP_PROPERTIES_H