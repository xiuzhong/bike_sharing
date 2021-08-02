class OwnerBooking < Booking
  before_validation :set_default_user_name

  # TODO
  # This is nasty workaround of the user_full_name validation,
  #   should be ditched when the user/owner is modeled, hence id is stored here
  DEFAULT_OWNER = '__DEFAULT_OWNER__'
  def set_default_user_name
    self.user_full_name ||= DEFAULT_OWNER
  end
end
