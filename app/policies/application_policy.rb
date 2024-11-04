class ArticlePolicy < ApplicationPolicy
  def index?
    true # 所有用户都可以查看文章列表
  end

  def show?
    true # 所有用户都可以查看文章
  end

  def create?
    user.present? # 只有登录用户可以创建文章
  end

  def update?
    user.present? && (record.user_id == user.id) # 只有作者可以更新文章
  end

  def destroy?
    user.present? && (record.user_id == user.id) # 只有作者可以删除文章
  end
end
