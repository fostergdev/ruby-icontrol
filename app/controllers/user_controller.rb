 class UserController < ApplicationController
    # Inclui módulo de autenticação que configura Current.user e métodos auxiliares
    include Authentication
    # Define o layout padrão para todas as views de admin
    # O arquivo de layout está em: app/views/layouts/admin.html.erb
    # layout "admin"

    # Filtro que executa antes de qualquer ação para garantir que o usuário é admin
    before_action :authenticate_user!

    private

    # Método de autorização que verifica se o usuário atual é administrador
    # Caso não seja, redireciona para a página inicial com mensagem de alerta
    def authenticate_user!
      # Usa safe navigation (&.) para evitar erros se Current.user for nil
      # Verifica se o usuário tem o atributo/admin? verdadeiro
      unless Current.user&.user?
        # Redireciona para root_path com mensagem flash de alerta
        redirect_to root_path, alert: "Acesso negado."
      end
      # Se a condição não for atendida (usuário é admin), a ação continua normalmente
    end
 end
