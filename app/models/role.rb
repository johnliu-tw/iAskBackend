class Role < ApplicationRecord
  has_and_belongs_to_many :users, :join_table => :users_roles

  belongs_to :resource,
             :polymorphic => true,
             :optional => true

  validates :resource_type,
            :inclusion => { :in => Rolify.resource_types },
            :allow_nil => true

  scopify

  # role's id = 1 SuperAdmin (admin)
  # role's id = 2 PlatformAdin (leader)
  # role's id = 3 - 5 iAsk, Reader, Udn editor (iAsk, reader, udn)
  # role's id >=6 team
end
