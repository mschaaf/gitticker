#!/usr/bin/ruby
=begin
    This file is part of gitticker.

    gitticker is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Foobar is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
=end
require 'rubygems'
require 'ruby-growl'

begin
  $0 = "gitticker.rb"

  g = Growl.new "localhost", "ruby-growl", ["ruby-growl Notification"]
  lscShown = false
  upcShown = false
  luccMsg = ""
  lcMsg = ""
  loop do
    so = ""
    IO.popen("git status -s") { |f| so = so + f.gets if not f.eof? }
    if "" != so and luccMsg != so then
      g.notify "ruby-growl Notification", "Last Un-Committed-Changes...", so
      luccMsg = so
    end

    so = ""
    IO.popen("git log -n 5 --pretty=format:'%h'") { |f| so = so + f.gets if not f.eof? }
    if "" != so and lcMsg != so then
      lcMsg = so
      so = ""
      IO.popen("git log -n 5 --pretty=format:'%h  %an  %ar%  %s'") { |f| so = so + f.gets if not f.eof? }
      g.notify "ruby-growl Notification", "Last Commits...", so 
    end

    so = ""
    IO.popen("git log -n 10 --branches --not --remotes --pretty=format:'%h  %an  %ar%  %s'") { |f| so = so + f.gets if not f.eof? }
    if "" != so and !upcShown
      upcShown = true
      g.notify "ruby-growl Notification", "Last Un-Pushed-Commits...", so, 0, true
    end

    so = ""
    IO.popen("git stash list") { |f| so = so + f.gets if not f.eof? }
    if "" != so and !lscShown
      lscShown = true
      g.notify "ruby-growl Notification", "Last Stashed-Changes...", so, 0, true
    end

    sleep 10
  end
end
