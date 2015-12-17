#!/usr/bin/env python3
# -*- coding:utf-8
#
"""get/set passwords from gnome keyring.
From: http://blog.florianheinle.de/post/47723652902/
        mutt-offlineimap-notmuch-goobook
"""

import keyring
import getpass


def get_password(service, user):
    """returns the password.
    """
    return keyring.get_password(service, user)


def set_password(service, user, password):
    """Set the password and username for a specific service.
    """
    keyring.set_password(service, user, password)

if __name__ == '__main__':
    from sys import argv, exit
    try:
        action, service, user = argv[1], argv[2], argv[3]
    except IndexError:
        exit('Syntax: [add|get] service user')

    if action == 'add':
        password = getpass.getpass()
        set_password(service, user, password)
    elif action == 'get':
        print(get_password(service, user))
    else:
        exit('Syntax: [add|get] service user')
