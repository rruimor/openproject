#-- encoding: UTF-8
#-- copyright
# OpenProject is a project management system.
# Copyright (C) 2012-2013 the OpenProject Foundation (OPF)
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2013 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See doc/COPYRIGHT.rdoc for more details.
#++

require 'tree' # gem install rubytree

class Redmine::MenuManager::TreeNode < Tree::TreeNode
  attr_reader :last_items_count

  def initialize(name, content = nil)
    @last_items_count = 0
    super
  end

  # Adds the specified child node to the receiver node.  The child node's
  # parent is set to be the receiver.  The child is added as the first child in
  # the current list of children for the receiver node.
  def prepend(child)
    raise "Child already added" if @children_hash.has_key?(child.name)

    @children_hash[child.name]  = child
    @children = [child] + @children
    child.parent = self
    return child

  end

  # Adds the specified child node to the receiver node.  The child node's
  # parent is set to be the receiver.  The child is added at the position
  # into the current list of children for the receiver node.
  def add_at(child, position)
    raise "Child already added" if @children_hash.has_key?(child.name)

    @children_hash[child.name]  = child
    @children = @children.insert(position, child)
    child.parent = self
    return child

  end

  def add_last(child)
    raise "Child already added" if @children_hash.has_key?(child.name)

    @children_hash[child.name]  = child
    @children <<  child
    @last_items_count += 1
    child.parent = self
    return child

  end

  # Adds the specified child node to the receiver node.  The child node's
  # parent is set to be the receiver.  The child is added as the last child in
  # the current list of children for the receiver node.
  def add(child)
    raise "Child already added" if @children_hash.has_key?(child.name)

    @children_hash[child.name]  = child
    position = @children.size - @last_items_count
    @children.insert(position, child)
    child.parent = self
    return child

  end

  # Wrapp remove! making sure to decrement the last_items counter if
  # the removed child was a last item
  def remove!(child)
    @last_items_count -= +1 if child && child.last
    super
  end


  # Will return the position (zero-based) of the current child in
  # it's parent
  def position
    self.parent.children.index(self)
  end
end
