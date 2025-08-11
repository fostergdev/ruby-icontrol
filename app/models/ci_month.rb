class CiMonth < ApplicationRecord
  belongs_to :user
  has_many :ci_entries, dependent: :destroy

  validates :month, inclusion: { in: 1..12 }
  validates :year, presence: true, numericality: { only_integer: true }

  # Opcional: validação para garantir unicidade do mês + ano por usuário
  validates :month, uniqueness: { scope: [ :year, :user_id ], message: "já existe para este usuário e ano" }
end
