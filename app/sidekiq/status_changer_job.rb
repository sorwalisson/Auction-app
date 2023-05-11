class StatusChangerJob
  include Sidekiq::Job

  def perform(id)
    AuctionLot.find_by(id: id).status_updater
  end
end
