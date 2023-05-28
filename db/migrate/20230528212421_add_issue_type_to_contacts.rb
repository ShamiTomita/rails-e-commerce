class AddIssueTypeToContacts < ActiveRecord::Migration[7.0]
  def change
    add_column :contacts, :issue_type, :integer
  end
end
