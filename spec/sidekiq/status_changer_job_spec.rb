require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe StatusChangerJob, type: :job do
  describe 'Sidekiq::Testing FAKE, check if the jobs are being queued' do
    it 'when auction is set to confirmed it must create a job' do
      new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
                               zip: "57000-100", cpf: "09814576492")
      new_auction = AuctionLot.create!(starting_time: 5.hours.from_now, ending_time: 3.days.from_now, auction_code: "bbc693221", starting_bid: 5000, bid_difference: 5, 
                                      user_id: new_admin.id, status: :awaiting_confirmation)
      new_product = Item.create!(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                                 weight: 247, height: 3, width: 8, depth: 3,
                                 category: 0, auction_lot_id: new_auction.id)
      
      Sidekiq::Worker.clear_all
      new_auction.status_updater
      
      expect(new_auction.status).to eq "confirmed"
      expect(StatusChangerJob.jobs.size).to eq 1
      expect(StatusChangerJob).to have_enqueued_sidekiq_job(1).at(new_auction.starting_time)
    end

    it 'when auction is set to running, it must created a job and change status to running' do
      new_admin = User.create!(name: "Walisson", email: "sorwalisson@leilaodogalpao.com.br", password: "password", address: "Avenida Fernandes Lima, 35",
                               zip: "57000-100", cpf: "09814576492")
      new_auction = AuctionLot.create!(starting_time: 5.hours.from_now, ending_time: 3.days.from_now, auction_code: "bbc693221", starting_bid: 5000, bid_difference: 5, 
                                      user_id: new_admin.id, status: :confirmed)
      new_product = Item.create!(name: "Ryzen 7 5800x", description: "Ryzen 7 5800x, A 3.8GHz processor with 8 cores with the new AMD technology AMD 3D V-Cache and Zen 3 architecture.",
                                      weight: 247, height: 3, width: 8, depth: 3,
                                      category: 0, auction_lot_id: new_auction.id)
      
      Sidekiq::Worker.clear_all
      new_auction.status_updater

      expect(new_auction.status).to eq ("running")
      expect(StatusChangerJob.jobs.size).to eq 1
      expect(StatusChangerJob).to have_enqueued_sidekiq_job(1).at(new_auction.ending_time)
    end 
  end
end
