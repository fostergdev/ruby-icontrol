class User::CiEntriesController < UserController
  def new
    @ci_month = Current.user.ci_months.find(params[:ci_month_id])
    @ci_entry = @ci_month.ci_entries.new(date: Date.new(@ci_month.year, @ci_month.month, 1))
  end

  def create
    @ci_month = Current.user.ci_months.find(params[:ci_month_id])
    @ci_entry = @ci_month.ci_entries.new(ci_entry_params)
    @ci_entry.user = Current.user

    if @ci_entry.save
      redirect_to user_root_path, notice: 'CI criada com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @ci_month = Current.user.ci_months.find(params[:ci_month_id])
    @ci_entry = @ci_month.ci_entries.find(params[:id])
  end

  def update
    @ci_month = Current.user.ci_months.find(params[:ci_month_id])
    @ci_entry = @ci_month.ci_entries.find(params[:id])

    if @ci_entry.update(ci_entry_params)
      redirect_to user_root_path, notice: 'CI atualizada com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @ci_month = Current.user.ci_months.find(params[:ci_month_id])
    @ci_entry = @ci_month.ci_entries.find(params[:id])
    @ci_entry.destroy
    redirect_to user_root_path, notice: 'CI removida com sucesso.'
  end

  def batch_create
    entry_params_list = params.require(:entries) # Agora é um array

    ActiveRecord::Base.transaction do
      entry_params_list.each do |entry_params|
        next if entry_params[:content].blank? || entry_params[:date].blank?

        date = entry_params[:date].to_date

        ci_month = Current.user.ci_months.find_or_create_by!(
          month: date.month,
          year: date.year
        )

        ci_month.ci_entries.create!(
          content: entry_params[:content],
          date: date,
          user: Current.user
        )
      end
    end

    redirect_to user_root_path, notice: "CIs criadas com sucesso!"
  rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = "Erro ao criar CIs: #{e.record.errors.full_messages.join(', ')}"
    @entries = params[:entries].map { |ep| CiEntry.new(ep.permit(:date, :content)) }
    render :batch_new, status: :unprocessable_entity
  rescue => e
    flash.now[:alert] = "Erro ao criar CIs: #{e.message}"
    @entries = params[:entries].map { |ep| CiEntry.new(ep.permit(:date, :content)) }
    render :batch_new, status: :unprocessable_entity
  end

  private

  def ci_entry_params
    params.require(:ci_entry).permit(:content, :date)
  end
end
