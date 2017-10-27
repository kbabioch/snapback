# Copyright (c) 2017 Karol Babioch <karol@babioch.de>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

install:

ifneq ($(strip $(DESTDIR)),)
	mkdir -p $(DESTDIR)
endif

	mkdir -p $(DESTDIR)/etc/conf.d
	mkdir -p $(DESTDIR)/usr/lib/snapback
	mkdir -p $(DESTDIR)/usr/lib/systemd/system

	install -Dm775 bin/snapback-snapshot $(DESTDIR)/usr/bin/snapback-snapshot
	install -Dm775 bin/snapback-backup $(DESTDIR)/usr/bin/snapback-backup
	install -Dm775 bin/snapback-prune $(DESTDIR)/usr/bin/snapback-prune

	install -Dm644 lib/lib.sh $(DESTDIR)/usr/lib/snapback/lib.sh

	install -Dm644 systemd/snapback-snapshot@.service $(DESTDIR)/usr/lib/systemd/system/snapback-snapshot@.service
	install -Dm644 systemd/snapback-snapshot@.timer $(DESTDIR)/usr/lib/systemd/system/snapback-snapshot@.timer
	install -Dm644 systemd/snapback-backup.service $(DESTDIR)/usr/lib/systemd/system/snapback-backup.service
	install -Dm644 systemd/snapback-backup.timer $(DESTDIR)/usr/lib/systemd/system/snapback-backup.timer
	install -Dm644 systemd/snapback-prune.service $(DESTDIR)/usr/lib/systemd/system/snapback-prune.service
	install -Dm644 systemd/snapback-prune.timer $(DESTDIR)/usr/lib/systemd/system/snapback-prune.timer

	install -Dm644 etc/snapback $(DESTDIR)/etc/conf.d/snapback

.PHONY: install

