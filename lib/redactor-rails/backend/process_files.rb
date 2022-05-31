module RedactorRails
  module Backend
    class ProcessFiles
      def initialize(files:, user:, type: RedactorRails::Picture)
        @files = files
        @user = user
        @type = type
        @uploaded_files = []
      end

      def call
        @files.each_with_object({}).with_index do |(file, object), id|
          uploaded_file = file_instance(file)

          if uploaded_file.save
            object.merge!(return_hash_formatter(uploaded_file, id))
          else
            object.merge!(error: uploaded_file.errors)
          end
        end
      end

      private

      def file_instance(file)
        @type.new.tap do |file_instance|
          file_instance.data = file
          file_instance.user = @user
          file_instance.assetable = @user
        end
      end

      def return_hash_formatter(uploaded_file, id)
        Hash[
          "file-#{id + 1}".to_sym,
          Hash[
            'url'.to_sym, uploaded_file.url,
            'id'.to_sym, uploaded_file.id
          ]
        ]
      end
    end
  end
end
