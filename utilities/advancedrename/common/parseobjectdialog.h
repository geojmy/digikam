/* ============================================================
 *
 * This file is a part of digiKam project
 * http://www.digikam.org
 *
 * Date        : 2009-11-20
 * Description : a dialog that can be used to display a configuration
 *               dialog for a parse object
 *
 * Copyright (C) 2009 by Andi Clemens <andi dot clemens at gmx dot net>
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

#ifndef PARSEOBJECTDIALOG_H
#define PARSEOBJECTDIALOG_H

// KDE includes

#include <kdialog.h>

namespace Digikam
{

class ParseObject;

class ParseObjectDialogPriv;

class ParseObjectDialog : public KDialog
{
    Q_OBJECT

public:

    ParseObjectDialog(ParseObject* parent);
    virtual ~ParseObjectDialog();

    void setSettingsWidget(QWidget* settingsWidget);

private:

    void setDialogTitle(const QString& title);
    void setDialogDescription(const QString& description);
    void setDialogIcon(const QPixmap& pixmap);

private:

    ParseObjectDialogPriv* const d;
};

} // namespace Digikam

#endif /* PARSEOBJECTDIALOG_H */
