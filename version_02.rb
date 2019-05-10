require 'json'

class Cho
  # メンバーJSONファイル
  MEMBER_FILE_PATH = "./json/members/20190510.json"
  # チーム名ファイル
  TEAM_NAME_FILE_PATH = "./json/team_names.json"
  # チーム数
  TEAM_COUNT = 2

  def self.sakutto
    members = []
    File.open(MEMBER_FILE_PATH) do |j|
      members = JSON.load(j)
    end

    p "参加者数: #{members.count}名"
    p "チーム数: #{TEAM_COUNT}"
    p "------------------------------------------------------"
    teams = []
    TEAM_COUNT.times do |i|
      teams[i] = {}
    end

    loop do
      shuffled_members = members.shuffle
      current_count = 0
      tmp_teams = []
      shuffled_members.each do |member|
        if current_count > TEAM_COUNT - 1
          current_count = 0
        end
        tmp_teams[current_count] = [] if !tmp_teams[current_count]
        tmp_teams[current_count] << member

        current_count += 1
      end

      tmp_teams.each_with_index do |tmp_members, i|
        rate_sum = 0
        tmp_members.each do |member|
          rate_sum += member["rate"]
        end
        teams[i] = {
          rate_ave: (rate_sum.to_f / tmp_members.length.to_f).round(1),
          members: tmp_members.map { |m| m["name"] }
        }
      end

      judgement = true
      standard_rate = nil
      teams.each do |team|
        if standard_rate == nil
          standard_rate = team[:rate_ave].round(0)
          next
        end

        next if !judgement

        judgement = false if team[:rate_ave].round(0) != standard_rate
      end

      break if judgement
    end

    team_names = []
    teams.each do |team|
      team_name = get_team_names(team_names)
      team_names << team_name

      p "【#{team_name}】- Members rate ave. #{team[:rate_ave]}"

      team[:members].each do |name|
        p name
      end
      p "------------------------------------------------------"
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
