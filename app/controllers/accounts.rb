class Accounts < Application
  # provides :xml, :yaml, :js

  def index
    @accounts = Account.all
    display @accounts
  end

  def show(id)
    @account = Account.get(id)
    raise NotFound unless @account
    display @account
  end

  def new
    only_provides :html
    @account = Account.new
    display Account
  end

  def edit(id)
    only_provides :html
    @account = Account.get(id)
    raise NotFound unless @account
    display @account
  end

  def create(account)
    @account = Account.new(params[:account])
    if @account.save
      redirect resource(@account), :message => {:notice => "Account was successfully created"}
    else
      render :new
    end
  end

  def update(account)
    @account = Account.get(account[:id] )
    raise NotFound unless @account
    if @account.update_attributes(account)
       redirect resource(@account)
    else
      display @account, :edit
    end
  end

  def destroy(id)
    @account = Account.get(id)
    raise NotFound unless @account
    if @account.destroy
      redirect resource(@accounts)
    else
      raise InternalServerError
    end
  end

end # Accounts
