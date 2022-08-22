require_relative '../lib/ingredient'
require_relative '../lib/snack'
require_relative '../lib/sandwich'
require_relative '../legacy_app'

RSpec.describe "Shit load of crap you were told would be 'state of the art' during the interview..." do
  describe Ingredient do
    it 'has a name' do
      expect(subject).to respond_to(:name)
    end

    describe '#name' do
      it 'is gloubiboulga' do
        expect(subject.name).to eq('gloubiboulga')
      end

      it 'or is the given name in argument' do
        expect(Ingredient.new('toto').name).to eq('toto')
      end
    end
  end

  describe Snack do
    it 'is shareable returns true' do
      expect(subject).to be_shareable
    end

    it "has no '#brick' method" do
      expect(subject).not_to respond_to(:brick)
    end
  end

  describe Sandwich do
    context 'when no sandwich has been created yet' do
      it 'can tell that no sanwich has been made so far' do
        expect(Sandwich.count).to be_zero
      end
    end

    context 'when creating sandwiches' do
      let!(:sandwich_number) { rand(10) }

      subject(:create_sandwiches) { sandwich_number.times { Sandwich.new } }

      it 'knows how many have been made so far' do
        create_sandwiches
        expect(Sandwich.count).to eq(sandwich_number)
      end
    end

    describe '#initialize' do
      it "doesn't fail when no ingredient is given" do
        expect { Sandwich.new }.not_to raise_error
      end

      it 'Raises an error when loaded with more than 14 ingredients' do
        expect do
          Sandwich.new('salad', 'jambon', 'fromage', 'tartiflett', 'mort au rat', 'biere', 'doigt',
                       'salad', 'jambon', 'fromage', 'tartiflett', 'mort au rat', 'biere', 'doigt',
                       'salad', 'jambon', 'fromage', 'tartiflett', 'mort au rat', 'biere', 'doigt')
        end.to raise_error('Too many ingredients')
      end

      it 'contains the given ingredients' do
        expect(Sandwich.new('tata').ingredients.map(&:name)).to include('tata')
      end
    end

    describe '.ingredients' do
      it 'has ingredients from Ingredients class' do
        sandwich = Sandwich.new('tata')
        expect(sandwich.ingredients).to include(be_an_instance_of(Ingredient))
      end
    end

    describe '#taste' do
      it 'returns delicious' do
        expect(Sandwich.new.taste).to match('delicious')
      end
    end

    describe '#pain_point' do
      it 'returns a string when there is at least one tomatoe' do
        sandwich = Sandwich.new('tomatoe')
        expect(sandwich.pain_point).to be_a(String)
      end

      it 'has no pain point when there is no tomatoe' do
        expect(Sandwich.new.pain_point).to be_falsey
      end
    end

    describe '#shareable' do
      it 'returns a truthy object' do
        expect(Sandwich.new(['tomatoe', nil].sample)).to be_shareable
      end

      it 'returns a string depending on the tomatoe situation' do
        expect(Sandwich.new('tomatoe').shareable?).not_to eq(Sandwich.new)
      end
    end

    describe '#add_ingredient' do
      let(:test_sandwich) { Sandwich.new }

      it 'does nothing when ingredient is not from class Ingredient' do
        expect { test_sandwich.add_ingredient('tata') }.not_to change(test_sandwich.ingredients, :count)
      end

      it 'adds the given ingredient when ingredient is from class Ingredient' do
        yummy = Ingredient.new

        expect { test_sandwich.add_ingredient(yummy) }.to change(test_sandwich.ingredients, :count).by(1)
      end

      let(:karadoc_sandwich) do
        Sandwich.new('salad', 'jambon', 'fromage', 'tartiflett', 'mort au rat', 'biere', 'doigt',
                     'salad', 'jambon', 'fromage', 'tartiflett', 'mort au rat', 'biere', 'doigt')
      end

      it 'does not accepts a 14th ingredient nor more' do
        expect { karadoc_sandwich.add_ingredient('des graines') }.to raise_error('Please no more ingredient !')
      end
    end

    describe '#can_be_eaten' do
      it 'can be eaten' do
        expect(Sandwich.new).to respond_to(:can_be_eaten)
      end
    end
  end

  describe LegacyCodeFromHellYouNeedToTest do
    subject(:hell_yeah) { LegacyCodeFromHellYouNeedToTest.new }

    it 'has two different sandwiches' do
      expect { hell_yeah }.to change(Sandwich, :count).by(2)
    end

    it 'has 3 ingredients' do
      expect(hell_yeah.my_sandwich.count).to eq(3)
    end

    it 'has more ingredients than my sandwich' do
      expect(hell_yeah.your_sandwich.ingredients.count).to be > (hell_yeah.my_sandwich.count)
    end
  end
end
