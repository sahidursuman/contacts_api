module Api
  module V1
    class ContactsController < ApiController
      skip_before_action :verify_authenticity_token

      rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
      rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

      def render_unprocessable_entity_response(exception)
        render json: {data: exception.record.errors}, status: :unprocessable_entity
      end

      def render_not_found_response(exception)
        render json: { data: exception.message }, status: :not_found
      end

      def index
        fetch_contacts = fetch_contacts(params)
        contacts = fetch_contacts.map do |contact|
          FieldPicker.new(ContactPresenter.new(contact), 'id,name,email,avatar').pick
        end
        render json: { data: contacts }.to_json
      end

      def show
        fetch_contact = Contact.find(params[:id])
        contact = FieldPicker.new(ContactPresenter.new(fetch_contact)).pick
        render json: { data: contact }.to_json
      end

      def create
        contact = Contact.new(contact_params)

        if contact.save
          contact = FieldPicker.new(ContactPresenter.new(contact)).pick
          render json: {status: 'SUCCESS', message:'Saved contact', data: contact}.to_json, status: :ok
        else
          render json: {status: 'ERROR', message:'Contact not saved', data: contact.errors}.to_json, status: :unprocessable_entity
        end
      end

      

      def update
        contact = Contact.find(params[:id])
        if contact.update_attributes(contact_params)
          contact = FieldPicker.new(ContactPresenter.new(contact)).pick
          render json: {status: 'SUCCESS', message:'Updated article', data: contact}.to_json,status: :ok
        else
          render json: {status: 'ERROR', message:'Contact not updated', data: contact.errors}.to_json,status: :unprocessable_entity
        end
      end

      private

      def contact_params
        params.require(:contact).permit(:name, :email, :avatar, :bio)
      end

      def number_check?(obj)
        obj = obj.to_s unless obj.is_a? String
        (/\A[+-]?\d+(\.[\d]+)?\z/.match obj).present?
      end

      def fetch_contacts(params)
        contacts = []
        return contacts unless params[:since].present? && number_check?(params[:since])
        
        if params[:since].to_i == 0 
          contacts = paginate(Contact.most_recent)
        elsif params[:since].to_i > 0
          # Fetch Contact with timestamp calculations
          # Convert timestamp to Datetime
          date_time_stamp = DateTime.strptime(params[:since].to_s,'%s')
          # Call the timestamp query
          contacts = Contact.find_by_timestamp(date_time_stamp)
          # Added pagination
          contacts = paginate(contacts)
        else
          contacts
        end
      end

    end
  end
  
end