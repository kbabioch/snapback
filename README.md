# snapback

Set of scripts to glue together snapshot capabilities from btrfs and backup
solutions from borg in a reliable and automated way.

Snapshots can be created periodally, even without a reliable internet
connection, whereas the content cannot be uploaded always (e.g. on a
laptop), etc. pp ...

**STILL UNDER DEVELOPMENT, ONLY A PROTOTYPE**

## THEORY OF OPERATOIN

- Create snapshot(s) periodically

- Backup snapshots with borg

- Remove snapshot(s) (optional)

## REQUIREMENTS

- btrfs + borg

## LICENSE

[![GNU GPLv3](http://www.gnu.org/graphics/gplv3-127x51.png "GNU GPLv3")](http://www.gnu.org/licenses/gpl.html)

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

