{
  title: "Knack",

  connection: {
    fields: [
      {
        name: "app_id",
        label: "Application ID",
        optional: false,
        hint: "Hover over gear icon, Click on API & Code -> get Application ID"
        },
      {
        name: "api_key",
        label: "API Key",
        control_type: "password",
        optional: false,
        hint: "Hover over gear icon, Click on API & Code -> get API Key"
        }
      ],

    authorization: {
      type: "custom_auth",

      credentials: ->(connection) {
        headers('X-Knack-Application-Id': connection["app_id"],
          'X-Knack-REST-API-Key': connection["api_key"])
        }
      }
    },

  test: ->(connection) {
    get("https://api.knack.com/v1/objects").dig("objects", 0)
    },

  object_definitions: {

    record_output: {
      fields: ->(_connection, config) {
        [
          { name: "id", label: "Record ID" }
          ].concat(
            if config["is_user_role"] == true
              [
                { name: "account_status" },
                { name: "approval_status" },
                { name: "profile_keys_raw", type: :array, of: :object,
                  properties: [
                  { name: "id" },
                  { name: "identifier"}
                  ]}
                ]
            else
              []
            end
            ).concat(
              get("https://api.knack.com/v1/objects/#{config['object']}/" \
                  "fields")['fields'].
                  reject {|f| f["type"]=='signature'||f["type"]=='equation' }.
                map do |f|
                  if f["type"] == 'address'
                    {
                      name: f["key"],
                      hint: "Provide longitude/latitude values if address" \
                      " input type is longitude/latitude else " \
                      "provide remaining fields",
                      label: f["label"].labelize,
                      type: :object, properties: [
                        { name: "longitude", type: :integer },
                        { name: "latitude", type: :integer },
                        { name: "zip" },
                        { name: "state" },
                        { name: "city" },
                        { name: "street2" },
                        { name: "street" }
                        ]
                      }
                  elsif f["type"] == 'name'
                    { name: f["key"], label: f["label"].labelize, type: :object,
                      properties: [
                      { name: "title" },
                      { name: "first" },
                      { name: "middle" },
                      { name: "last" }]
                      }
                  elsif f["type"] == 'connection'
                    { name: f["key"], label: f["label"].labelize, type: :array,
                      of: :object, properties: [
                      { name: "id" },
                      { name: "identifier" }
                      ]
                      }
                  elsif f["type"] == 'rating'
                    { name: f["key"], label: f["label"].labelize,
                      type: :integer, hint: "Values are 1 to 3" }
                  elsif f["type"] == 'number'
                    { name: f["key"], label: f["label"].labelize,
                      type: :integer }
                  elsif f["type"] == 'auto_increment'
                    { name: f["key"], label: f["label"].labelize,
                      type: :integer }
                  elsif f["type"] == 'phone'
                    { name: f["key"], label: f["label"].labelize, type: :object,
                      properties: [
                      { name: "formatted" },
                      { name: "full" },
                      { name: "number" },
                      { name: "area" }]
                      }
                  elsif f["type"] == 'rich_text'
                    { name: f["key"], label: f["label"].labelize,
                      hint: "HTML can be used" }
                  elsif f["type"] == 'image'
                    { name: f["key"], label: f["label"].labelize, type: :object,
                      properties: [
                      { name: "id" },
                      { name: "application_id" },
                      { name: "s3", type: :boolean },
                      { name: "type" },
                      { name: "filename" },
                      { name: "url" },
                      { name: "thumb_url" },
                      { name: "size", type: :integer }]
                      }
                  elsif f["type"] == 'file'
                    { name: f["key"], label: f["label"].labelize, type: :object,
                      properties: [
                      { name: "id" },
                      { name: "application_id" },
                      { name: "s3", type: :boolean },
                      { name: "type" },
                      { name: "filename" },
                      { name: "url" },
                      { name: "thumb_url" },
                      { name: "size", type: :integer }]
                      }
                  elsif f["type"] == 'link'
                    { name: f["key"], label: f["label"].labelize, type: :object,
                      properties: [
                      { name: "url" },
                      { name: "label" }]
                      }
                  elsif f["type"] == 'email'
                    { name: f["key"], label: f["label"].labelize, type: :object,
                      properties: [
                      { name: "email" },
                      { name: "label" }]
                      }
                  elsif f["type"] == 'user_roles'
                    { name: f["key"], type: :array, label: f["label"].labelize,
                      properties: [
                      { name: f["key"], label: f["label"].labelize }
                      ] }
                  elsif f["type"] == 'timer'
                    { name: f["key"], label: f["label"].labelize,
                      type: :object, properties: [
                      { name: "times", type: :array, of: :object, properties: [
                        { name: "from", type: :object, properties: [
                          { name: "date", type: :date_time },
                          { name: "date_formatted" },
                          { name: "hours" },
                          { name: "minutes" },
                          { name: "am_pm", label: "AM PM" },
                          { name: "unix_timestamp", type: :integer },
                          { name: "timestamp", type: :date_time },
                          { name: "time", type: :integer }]
                          },
                        { name: "to", type: :object, properties: [
                          { name: "date", type: :date_time },
                          { name: "date_formatted" },
                          { name: "hours" },
                          { name: "minutes" },
                          { name: "am_pm", label: "AM PM" },
                          { name: "unix_timestamp", type: :integer },
                          { name: "timestamp", type: :date_time },
                          { name: "time", type: :integer }
                          ]
                          }]
                        },
                      { name: "total_time", type: :integer }]
                      }
                  elsif f["type"] == 'date_time'
                    { name: f["key"], label: f["label"].labelize,
                      type: :object, properties: [
                      { name: "date", type: :date_time },
                      { name: "date_formatted" },
                      { name: "hours", type: :integer },
                      { name: "minutes", type: :integer },
                      { name: "am_pm", label: "AM PM" },
                      { name: "unix_timestamp", type: :integer },
                      { name: "timestamp", type: :date_time },
                      { name: "time", type: :integer }]
                      }
                  else
                    { name: f["key"], label: f["label"].labelize,
                      type: f["type"] }
                  end
                end)
        }
      },

    record_search: {
      fields: ->(_connection, config) {
        [
          { name: "id", label: 'Record ID' }
          ].concat(
            if config["is_user_role"] == true
              [
                { name: "account_status" },
                { name: "approval_status" },
                { name: "profile_keys_raw", type: :array,
                  of: :object, properties: [
                  { name: "id" },
                  { name: "identifier"}
                  ]}
                ]
            else
              []
            end
            ).concat(
              get("https://api.knack.com/v1/objects/#{config['object']}/" \
                  "fields")['fields'].
                  reject {|f| f["type"]=='signature'||
                          f["type"]=='equation'||f["type"]=='user_roles' }.
                map do |f|
                  if f["type"] == 'address'
                    {
                      name: f["key"],
                      hint: "Provide longitude/latitude values if " \
                            "address input type is longitude/latitude " \
                            "else provide remaining fields",
                      label: f["label"].labelize,
                      type: :object, properties: [
                        { name: "longitude", type: :integer },
                        { name: "latitude", type: :integer },
                        { name: "zip" },
                        { name: "state" },
                        { name: "city" },
                        { name: "street2" },
                        { name: "street" }
                        ]
                      }
                  elsif f["type"] == 'name'
                    { name: f["key"], label: f["label"].labelize,
                      type: :object, properties: [
                      { name: "title" },
                      { name: "first" },
                      { name: "middle" },
                      { name: "last" }]
                      }
                  elsif f["type"] == 'rating'
                    { name: f["key"], label: f["label"].labelize,
                      type: :integer, hint: "Values are 1 to 3" }
                  elsif f["type"] == 'number'
                    { name: f["key"], label: f["label"].labelize,
                      type: :integer }
                  elsif f["type"] == 'auto_increment'
                    { name: f["key"], label: f["label"].labelize,
                      type: :integer }
                  elsif f["type"] == 'phone'
                    { name: f["key"], label: f["label"].labelize,
                      type: :object, properties: [
                      { name: "phone_number" }]
                      }
                  elsif f["type"] == 'rich_text'
                    { name: f["key"], label: f["label"].labelize,
                      hint: "HTML can be used" }
                  elsif f["type"] == 'image'
                    { name: f["key"], label: f["label"].labelize,
                      type: :object, properties: [
                      { name: "filename" },
                      { name: "url" }]
                      }
                  elsif f["type"] == 'file'
                    { name: f["key"], label: f["label"].labelize,
                      type: :object, properties: [
                      { name: "filename" },
                      { name: "url" }]
                      }
                  elsif f["type"] == 'link'
                    {
                      name: f["key"], label: f["label"].labelize,
                      type: :object, properties: [
                      { name: "url" }
                      ]
                    }
                  elsif f["type"] == 'email'
                    {
                      name: f["key"], label: f["label"].labelize,
                      type: :object, properties: [
                      { name: "email" }
                      ]
                    }
                  elsif f["type"] == "timer"
                    {
                      name: f["key"],
                      label: f["label"].labelize,
                      type: :object,
                      properties: [
                      { name: "times",
                        type: :array,
                        of: :object,
                        properties: [
                        { name: "from",
                          type: :object,
                          properties: [{ name: "date", type: :date_time }] },
                        { name: "to",
                          type: :object,
                          properties: [{ name: "date", type: :date_time }] }] }]
                    }
                  elsif f["type"] == "date_time"
                    {
                      name: f["key"], label: f["label"].labelize,
                      type: :object,
                      properties:[{ name: "date", type: :date_time }]
                    }
                  else
                    { name: f["key"], label: f["label"].labelize,
                      type: f["type"] }
                  end
                end
            )
      }
    }
  },
  methods: {

    convert_time_out: lambda do |time_val|
      time_val["date"] = time_val["date"].to_time(format: "%m/%d/%Y")
      time_val["timestamp"] = time_val["timestamp"].
                              to_time(format: "%m/%d/%Y %I:%M %p")
    end,
    format_output: lambda do |res|
      res&.each do |key, val|
        if val.is_a?(Array) && val.first&.class.to_s == "String"
          res[key] = val.map { |value| { key => value } }
        elsif val.is_a?(Hash)
          if val.keys.include?("date")
            call("convert_time_out", val)
          elsif val.keys.include?("date_time")
            val["times"]&.first&.each do |_t_k, t_v|
              call("convert_time_out", t_v)
            end
          elsif val.keys.include?("times")
            val["times"]&.first&.each do |_t_k, t_v|
              call("convert_time_out", t_v)
            end
          end
        end
      end
    end
  },

  actions: {
    search_record: {
      description: "Search for <span class='provider'>record</span>" \
      " in <span class='provider'>Knack</span>",

      config_fields: [
        {
          name: "object",
          control_type: :select,
          pick_list: "objects",
          optional: false
        },
        {
          name: "is_user_role",
          type: :boolean,
          hint: "True if 'object' is user roles",
          optional: false
        }
      ],

      input_fields: lambda do |object_definitions|
        object_definitions["record_search"].
          ignored("id", "account_status",
                  "approval_status", "profile_keys_raw").
          concat([
                   {  name: "rows_per_page", label: "Page Size",
                      sitcky: true,
                      hint: "Number of records to return from one request" },
                   {  name: "page", label: "Page no",
                      sitcky: true,
                      hint: "default page is 1" },
                   {  name: "sort_field", label: "Sort column",
                      sticky: true },
                   {  name: "sort_order", label: "Sort order",
                      sticky: true,
                      control_type: "select",
                      pick_list: [
                        ["Ascending", "asc"],
                        ["Deschendig", "desc"]
                      ] }
                 ])
      end,

      execute: lambda do |_connection, input|
        rows_per_page = input.delete("rows_per_page")
        page = input.delete("page")
        sort_field = input.delete("sort_field")
        sort_order = input.delete("sort_order")
        object_id = input["object"]
        # call("format_input", { object_id: object_id })
        # format_input(input)
        filters = input.reject { |k, _v| k == "object" }.map do |k, v|
          if v.is_a?(Hash)
            v.map do |key, va|
              { "field" => k, "operator" => "is", "value" => va,
                "field_name" => key }
            end
          else
            { "field" => k, "operator" => "is", "value" => v }
          end
        end&.flatten

        result = get("https://api.knack.com/v1/objects/#{object_id}/records").
                 params(format: "raw",
                        rows_per_page: rows_per_page,
                        page: page,
                        sort_field: sort_field,
                        sort_order: sort_order,
                        filters: filters.to_json)
        result["records"].each { |res| call("format_output", res) }
        result
      end,

      output_fields: lambda do |object_definitions|
        [
          {
            name: "records",
            type: :array, of: :object,
            properties: object_definitions["record_output"]
          }
        ]
      end
    }
  },

  pick_lists: {
    objects: lambda do
      get("https://api.knack.com/v1/objects")["objects"].pluck("name", "key")
    end
  }
}
