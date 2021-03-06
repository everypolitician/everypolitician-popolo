# frozen_string_literal: true

require_relative 'collection'
require_relative 'entity'

module Everypolitician
  module Popolo
    class Person < Entity
      class Error < StandardError; end

      def name
        document.fetch(:name, nil)
      end

      def email
        document.fetch(:email, nil)
      end

      def image
        document.fetch(:image, nil)
      end

      def gender
        document.fetch(:gender, nil)
      end

      def national_identity
        document.fetch(:national_identity, nil)
      end

      def summary
        document.fetch(:summary, nil)
      end

      def birth_date
        document.fetch(:birth_date, nil)
      end

      def death_date
        document.fetch(:death_date, nil)
      end

      def honorific_prefix
        document.fetch(:honorific_prefix, nil)
      end

      def honorific_suffix
        document.fetch(:honorific_suffix, nil)
      end

      def links
        document.fetch(:links, [])
      end

      def link(type)
        links.find(-> { {} }) { |i| i[:note] == type }[:url]
      end

      def contact_details
        document.fetch(:contact_details, [])
      end

      def contact(type)
        contact_details.find(-> { {} }) { |i| i[:type] == type }[:value]
      end

      def phone
        contact('phone')
      end

      def fax
        contact('fax')
      end

      def twitter
        contact('twitter') || link('twitter')
      end

      def facebook
        link('facebook')
      end

      def sort_name
        name
      end

      def family_name
        document.fetch(:family_name, nil)
      end

      def given_name
        document.fetch(:given_name, nil)
      end

      def patronymic_name
        document.fetch(:patronymic_name, nil)
      end

      def images
        document.fetch(:images, [])
      end

      def other_names
        document.fetch(:other_names, [])
      end

      def sources
        document.fetch(:sources, [])
      end

      def name_at(date)
        return name unless key?(:other_names)
        historic = other_names.select { |n| n.key?(:end_date) }
        return name if historic.empty?
        at_date = historic.select do |n|
          n[:end_date] >= date && (n[:start_date] || '0000-00-00') <= date
        end
        return name if at_date.empty?
        fail Error, "Too many names at #{date}: #{at_date}" if at_date.count > 1
        at_date.first[:name]
      end

      def memberships
        popolo.memberships.where(person_id: id)
      end
    end

    class People < Collection
      entity_class Person
    end
  end
end
