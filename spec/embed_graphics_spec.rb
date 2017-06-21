require 'rspec'

describe 'Embed Graphics' do
  context 'Screenshots' do
    it 'pass with screenshots' do |example|
      example.metadata[:screenshots] = []

      example.metadata[:screenshots] << {
        caption: 'Playstore1',
        path: '../spec/support/assets/images/screen_1.png'
      }
      example.metadata[:screenshots] << {
        caption: 'Calculator1',
        path: '../spec/support/assets/images/screen_2.png'
      }
      example.metadata[:screenshots] << {
        caption: 'Calculator2',
        path: '../spec/support/assets/images/screen_2.png'
      }
      example.metadata[:screenshots] << {
        caption: 'Calculator3',
        path: '../spec/support/assets/images/screen_2.png'
      }
      example.metadata[:screenshots] << {
        caption: 'Paystore2',
        path: '../spec/support/assets/images/screen_1.png'
      }

      expect(true).to eq(true)
    end

    it 'fail with screenshots' do |example|
      example.metadata[:screenshots] = []

      example.metadata[:screenshots] << {
        caption: 'Playstore1',
        path: '../spec/support/assets/images/screen_1.png'
      }
      example.metadata[:screenshots] << {
        caption: 'Paystore1',
        path: '../spec/support/assets/images/screen_1.png'
      }

      expect(true).to eq(false)
    end

    xit 'pending with screenshots' do |example|
      example.metadata[:screenshots] = []

      example.metadata[:screenshots] << {
        caption: 'Playstore1',
        path: '../spec/support/assets/images/screen_1.png'
      }
      example.metadata[:screenshots] << {
        caption: 'Paystore1',
        path: '../spec/support/assets/images/screen_1.png'
      }

      expect(true).to eq(false)
    end
  end

  context 'Screenrecord' do
    it 'pass with screenrecord' do |example|
      example.metadata[:screenrecord] = '../spec/support/assets/videos/screen_record.mp4'

      expect(true).to eq(true)
    end

    it 'fail with screenrecord' do |example|
      example.metadata[:screenrecord] = '../spec/support/assets/videos/screen_record.mp4'

      expect(true).to eq(false)
    end

    xit 'pending with screenrecord' do |example|
      example.metadata[:screenrecord] = '../spec/support/assets/videos/screen_record.mp4'

      expect(true).to eq(false)
    end
  end

  context 'Screenrecord & Screenshot' do
    it 'pass with screenrecord & screenshot' do |example|
      example.metadata[:screenshots] = []

      example.metadata[:screenshots] << {
        caption: 'Playstore1',
        path: '../spec/support/assets/images/screen_1.png'
      }
      example.metadata[:screenshots] << {
        caption: 'Paystore1',
        path: '../spec/support/assets/images/screen_1.png'
      }

      example.metadata[:screenrecord] = '../spec/support/assets/videos/screen_record.mp4'

      expect(true).to eq(true)
    end

    it 'fail with screenrecord & screenshot' do |example|
      example.metadata[:screenshots] = []

      example.metadata[:screenshots] << {
        caption: 'Playstore1',
        path: '../spec/support/assets/images/screen_1.png'
      }
      example.metadata[:screenshots] << {
        caption: 'Paystore1',
        path: '../spec/support/assets/images/screen_1.png'
      }

      example.metadata[:screenrecord] = '../spec/support/assets/videos/screen_record.mp4'

      expect(true).to eq(false)
    end

    xit 'pending with screenrecord & screenshot' do |example|
      example.metadata[:screenshots] = []

      example.metadata[:screenshots] << {
        caption: 'Playstore1',
        path: '../spec/support/assets/images/screen_1.png'
      }
      example.metadata[:screenshots] << {
        caption: 'Paystore1',
        path: '../spec/support/assets/images/screen_1.png'
      }

      example.metadata[:screenrecord] = '../spec/support/assets/videos/screen_record.mp4'

      expect(true).to eq(false)
    end
  end

end
