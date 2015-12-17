#!/usr/bin/env python2
# -*- coding:utf-8
#
"""notification on new mail"""

import pyinotify
import pynotify
from gtk.gdk import pixbuf_new_from_file

from mailbox import MaildirMessage
import os
import sys

ICON = pixbuf_new_from_file('/usr/share/icons/gnome/32x32/status/mail-unread.png')
MAILDIRS = [
    '/home/sl/.mail/sl/INBOX/new/',
]
pynotify.init('notify.py')


def notify(event):
    """show notifications"""
    mail = MaildirMessage(message=open(event.pathname, 'r'))
    n = pynotify.Notification(
            "New email",
            "From: %s\n%s" % (mail['From'], mail['Subject'])
        )
    n.set_icon_from_pixbuf(ICON)
    n.set_timeout(12000)
    n.show()


if __name__ == '__main__':
    # daemonize with double fork
    try:
        pid = os.fork()
        if pid > 0:
            sys.exit(0)
    except OSError as e:
        print >> sys.stderr, "fork #2 failed: %d (%s)" % (e.errno, e.strerror)
        sys.exit(1)

    # now set up maildir watching
    wm = pyinotify.WatchManager()
    notifier = pyinotify.Notifier(wm, notify)
    for maildir in MAILDIRS:
        wm.add_watch(maildir, pyinotify.IN_CREATE | pyinotify.IN_MOVED_TO)
    notifier.loop()
