class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  before_action :authenticate_user!
  check_authorization unless: :skip_authorization?

  rescue_from CanCan::AccessDenied do |e|
    respond_to do |format|
      # Importante: si root apunta al dashboard (que chequea permisos),
      # redirigir acá a otra ruta segura evita un bucle.
      format.html { redirect_to users_path, alert: e.message } # temporal
      format.json { render json: { error: "Forbidden" }, status: :forbidden }
    end
  end

  def after_sign_in_path_for(resource)
    # Cuando todo esté ok podés volver a root_path si querés.
    users_path
  end

  private
  def skip_authorization?
    devise_controller? ||
      controller_path.start_with?("active_storage/") ||
      controller_path == "rails/health"
  end
end
