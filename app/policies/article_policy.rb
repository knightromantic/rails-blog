# app/policies/article_policy.rb
class ArticlePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.present?
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end
end
