require_relative 'config'

class FlightControlsGroup < FXGroupBox
  def initialize(parent, window, name, target)
    @window = window
    @control_name = name
    @control_desired = target
    super(parent, @control_name.to_s.capitalize, FRAME_RIDGE | LAYOUT_SIDE_LEFT)
    self.setFont(FXFont.new(getApp(), "Helvetica", 14, 0))

    spinner = FXRealSpinner.new(self, 7, @control_desired,
                      FXDataTarget::ID_VALUE, FRAME_NORMAL
                               )
    spinner.setIncrement(Config::CONTROLS_STEP)
    spinner.range = -180..180

    @control_desired.connect(SEL_COMMAND, method(:update_desired))
  end

  #######
  private
  #######

    def update_desired(sender, selector, data)
      @window.writeout(@control_name[0], data)
    end
end
