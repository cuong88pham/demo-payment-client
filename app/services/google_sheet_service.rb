require "google_drive"
class GoogleSheetService 
  def initialize(title)
    session = GoogleDrive::Session.from_service_account_key(ENV['GOOGLE_APPLICATION_CREDENTIALS'])
    spreadsheet = session.spreadsheet_by_title(title)
    worksheet = spreadsheet.worksheets.first
    return worksheet
  end
end