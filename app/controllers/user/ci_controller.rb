class User::CiController < UserController
  before_action :set_ci_month, only: [ :show, :edit, :update, :destroy ]

  def index
    @ci_months = Current.user.ci_months.order(year: :desc, month: :desc)
  end

  def show
    @ci_entries = @ci_month.ci_entries.order(date: :asc)
    @ci_entry = CiEntry.new
  end

def new
  @ci_entry = CiEntry.new(ci_month_id: params[:ci_month_id])
end


  def create
    @ci_month = Current.user.ci_months.new(ci_month_params)
    if @ci_month.save
      redirect_to user_ci_path(@ci_month), notice: "Mês criado com sucesso."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @ci_month.update(ci_month_params)
      redirect_to user_ci_path(@ci_month), notice: "Mês atualizado."
    else
      render :edit
    end
  end

  def destroy
    @ci_month.destroy
    redirect_to user_ci_index_path, notice: "Mês removido."
  end

  private

  def set_ci_month
    @ci_month = Current.user.ci_months.find(params[:id])
  end

  def ci_month_params
    params.require(:ci_month).permit(:month, :year)
  end
end
