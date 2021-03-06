#-- copyright
# OpenProject is a project management system.
#
# Copyright (C) 2012-2013 the OpenProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# See doc/COPYRIGHT.rdoc for more details.
#++

require_relative 'migration_utils/attachable_utils'

class AddMissingAttachableJournals < ActiveRecord::Migration
  include Migration::Utils
  include Migration::Utils::AttachableUtils

  def up
    say_with_time_silently "Add missing attachable journals" do
      add_missing_attachable_journals
    end
  end

  def down
  end
end
