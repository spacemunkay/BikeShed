require 'spec_helper'

describe User do
  describe 'validations' do
    it { should have(1).error_on(:first_name) }
    it { should have(1).error_on(:last_name) }
  end

# describe 'is a member of team' do
#   let(:user) { create(:user) }
#   let(:team) { create(:team) } 
#   subject { user.is_a_member_of?(team) }

#   context 'it not a member of the team' do
#     it { should be_false }
#   end

#   context 'is a member of the team already' do
#     before { user.teams << team }
#     it { should be_true }
#   end

#   context 'is the captain of the team' do
#     let(:team) { create(:team, :captain => user) }
#     it { should be_true }
#   end
# end

end
