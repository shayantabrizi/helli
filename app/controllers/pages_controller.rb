class PagesController < ApplicationController
  def home
    @ss=Seminar.all;
    @sems=Hash.new
    @ss.each do |t|
      @sems[t.id]=Set.new;
      t.topics.each do |u|
        @sems[t.id].add(u);
      end
    end
  end

  def done
  end
end
