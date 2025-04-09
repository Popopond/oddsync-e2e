require 'rails_helper'

RSpec.describe 'Home page', type: :system do
  let!(:user) { create(:user) }
  let!(:room) { create(:room, name: 'Tea1') }
  let!(:upcoming_booking) do
    create(:booking,
           user: user,
           room: room,
           start_time: 1.day.from_now)
  end
  let!(:recent_booking) do
    create(:booking,
           user: user,
           room: room,
           start_time: 1.day.ago)
  end

  before do
    sign_in user
    visit root_path
  end

  describe 'header section' do
    it 'displays the header with correct elements' do
      within('[data-testid="header"]') do
        expect(page).to have_css('[data-testid="header-title"]', text: 'Meeting Room Booking')
        expect(page).to have_css('[data-testid="month-display"]')
        expect(page).to have_css('[data-testid="week-view-button"]')
        expect(page).to have_css('[data-testid="add-event-button"]')
      end
    end
  end

  describe 'welcome section' do
    it 'displays welcome message and logo' do
      within('[data-testid="welcome-section"]') do
        expect(page).to have_css('[data-testid="welcome-logo"]')
        expect(page).to have_css('[data-testid="welcome-title"]', text: 'ยินดีต้อนรับสู่ ODDSYNC')
        expect(page).to have_css('[data-testid="welcome-subtitle"]', text: 'ระบบจองห้องประชุมออนไลน์')
      end
    end
  end

  describe 'bookings section' do
    context 'upcoming bookings' do
      it 'displays upcoming bookings' do
        within('[data-testid="upcoming-bookings"]') do
          expect(page).to have_css('[data-testid="upcoming-bookings-title"]', text: 'การจองที่กำลังจะถึง')
          within('[data-testid="upcoming-bookings-list"]') do
            expect(page).to have_css('[data-testid="booking-room-name"]', text: room.name)
            expect(page).to have_css('[data-testid="booking-details-link"]', text: 'ดูรายละเอียด')
          end
        end
      end
    end

    context 'recent bookings' do
      it 'displays recent bookings' do
        within('[data-testid="recent-bookings"]') do
          expect(page).to have_css('[data-testid="recent-bookings-title"]', text: 'การจองล่าสุด')
          within('[data-testid="recent-bookings-list"]') do
            expect(page).to have_css('[data-testid="booking-room-name"]', text: room.name)
            expect(page).to have_css('[data-testid="booking-details-link"]', text: 'ดูรายละเอียด')
          end
        end
      end
    end

    context 'when no bookings exist' do
      before do
        Booking.destroy_all
        visit root_path
      end

      it 'displays empty state messages' do
        expect(page).to have_css('[data-testid="no-upcoming-bookings"]', text: 'ไม่มีการจองที่กำลังจะถึง')
        expect(page).to have_css('[data-testid="no-recent-bookings"]', text: 'ยังไม่มีประวัติการจอง')
      end
    end
  end

  describe 'action button section' do
    it 'displays booking button' do
      within('[data-testid="action-button-section"]') do
        expect(page).to have_css('[data-testid="new-booking-button"]', text: 'จองห้องประชุม')
        click_link 'จองห้องประชุม'
        expect(page).to have_current_path(new_booking_path)
      end
    end
  end
end 