module SessionsHelper
  def active_session
    @active_session unless @active_session.blank?
    code = cookies[:pyw_session_code]
    if code.blank?
      code = params[:session_code]
    end
    @active_session = Session.where(session_code: code, is_active: true).last
  end

  def active_session_user
    @current_user unless @current_user.blank?
    code = cookies[:pyw_session_code]
    if code.blank?
      code = params[:session_code]
    end
    session = Session.where(session_code: code, is_active: true).includes(:user).last
    session.blank? || code.blank? ? nil : @current_user = session.user
  end
  alias_method :current_user, :active_session_user

  def clear_session_cookie
    cookies.delete(:pyw_session_code)
  end
  
  def is_active_session
    !active_session.blank?
  end

  def save_session_cookie(session)
    cookies.permanent[:pyw_session_code] = session.code
  end

  def save_session_for_client(client)
    s = Session.new(ip_address: request.remote_ip)
    s.user = user
    s.save_with_session_code
    save_session_cookie(s)
    s
  end
end
