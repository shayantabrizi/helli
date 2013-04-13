class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    sem = Seminar.all
    @seminars = Hash.new
    @topics = Hash.new
    sem.each do |t|
      @seminars[t.id] = t;
      @topics[t.id] = Hash.new
      t.topics.each do |u|
        @topics[t.id][u.id] = u;
        @user.selections.build(:seminar_id=>t.id, :topic_id=>u.id)
      end
    end
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit    
    sem = Seminar.all
    @seminars = Hash.new
    @topics = Hash.new
    sem.each do |t|
      @seminars[t.id] = t;
      @topics[t.id] = Hash.new
      t.topics.each do |u|
        @topics[t.id][u.id] = u;
      end
    end
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    if not(check(@user))
      flash.now[:error] = "error"# Not quite right!
      render 'new'
    end


    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    u = @user
    u.assign_attributes(params[:user]);
    
    if not(check(u))
      flash.now[:error] = "error"# Not quite right!
      render 'new'
    end

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
private


  def check(user)
    h = Hash.new
    user.selections.each do |t|
      h[t.seminar_id]||=Set.new
      h[t.seminar_id].add(t);
      if not (t.rank.blank? || (-1..9) === t.rank)
        return false;
      end
    end
    h.each do |key, value|
      if not(checkSeminar(value))
        return false;
      end
    end
    return true;
  end
  def checkSeminar(sems)
    ch = false;
    minus = false
    h = Hash.new
    sems.each do |t|
      if t.rank == -1
        minus = true;
      else
        if not(t.rank.blank?)
          ch = true;
        end
      end
    end
    if minus == ch and ch == true
      return false;
    end

    if minus
      return true;
    end


    sems.each do |t|
      if t.rank.blank?
        return false;
      end
      h[t.rank] = true;
    end
    (0..9).each do |t|
      if not(h[t])
        return false;
      end
    end
    return true;
  end
  
end
