# Cinemap

Map of shooting locations for film, tv, etc.

Feel free to use the code in your project, I am using a LGPL license, which means:

- you are free to use the classes as you wish
- you can use the classes even in commercial projects
- if you modify the classes, you have to apply LGPL to the modified classes and reveal their source code

I am using other libraries in this project:

- Bootstrap
	- HTML, CSS, and JS framework for developing responsive, mobile first projects on the web
	- http://getbootstrap.com/
	- Code licensed under MIT, documentation under CC BY 3.0.
	- https://github.com/twbs/bootstrap/blob/master/LICENSE
	- http://creativecommons.org/licenses/by/3.0/
- Leaflet
	- JavaScript library for mobile-friendly interactive maps
	- http://leafletjs.com
	- own license, see LICENSE file in leaflet directory



## Git repository

Short details about the structure of the git repository:
The branches are constructed regarding the git branching model of http://nvie.com/posts/a-successful-git-branching-model/

This means, there are always at least three branches:

1. `master` - contains released versions
2. `develop` - main synchronisation branch for feature, release, and hotfix branches
3. `feature-work` - main wirking branch for development

Additionally, the following branches my occur:

- `feature-*` - writing a special feature
- `release-*` - synchronizing release versions between `develop` and `master`
- `hotfix-*` - fast bugfixes

## Copyright

Copyright 2013-2015 Ekkart Kleinod <ekleinod@edgesoft.de>

The program is distributed under the terms of the GNU Lesser General Public License.

See COPYING and COPYING.LESSER for details.

This file is part of edgeUtils.

edgeUtils is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

edgeUtils is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with edgeUtils.  If not, see <http://www.gnu.org/licenses/>.

