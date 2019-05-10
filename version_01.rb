require 'json'

class Cho
  # メンバーJSONファイル
  MEMBER_FILE_PATH = "./json/members/20190426.json"
  # チーム名ファイル
  TEAM_NAME_FILE_PATH = "./json/team_names.json"
  # チーム数
  TEAM_COUNT = 2

  def self.sakutto
    members = []
    File.open(MEMBER_FILE_PATH) do |j|
      members = JSON.load(j)
    end

    p "メンバー数: #{members.count}"
    p "チーム数: #{TEAM_COUNT}"
    p "---------------------------"
    teams = {}
    TEAM_COUNT.times do |i|
      teams[i] = []
    end

    # RateごとにGroupを分ける
    rate_groups = members.group_by{ |member| member["rate"] }
    # 順番に振り分けるために使う
    current_count = 0

    rate_groups.each do |rate, rate_members|
      # 配列をシャッフルする
      shuffled_members = rate_members.shuffle
      shuffled_members.each do |member|

        if current_count > TEAM_COUNT - 1
          current_count = 0
        end
        teams[current_count] << member["name"]

        current_count += 1
      end
    end

    team_names = []
    teams.each do |key, data|
      team_name = get_team_names(team_names)
      team_names << team_name


      p "【#{team_name}】#{data.count}名"

      data.each do |member|
        p member
      end
      p "---------------------------"
    end
  end

  private
  def self.get_team_names(exclude_array)
    team_names = []
    File.open(TEAM_NAME_FILE_PATH) do |j|
      team_names = JSON.load(j)
    end

    # すでに使用されたチーム名を省く
    choices = []
    team_names.each do |team_name|
      choices << team_name unless exclude_array.include?(team_name)
    end

    choices.sample
  end
end

Cho.sakutto
