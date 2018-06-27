{
  title: "Caspio",

  secure_tunnel: true,

  connection: {
    fields: [
      {
        name: "subdomain",
        control_type: "subdomain",
        url: ".caspio.com",
        optional: false,
        hint: "Your caspio subdomain found in your caspio URL",
      },
      {
        name: "client_id",
        label: "Client ID",
        optional: false,
        hint: "Your client ID can be found from Account -> Access Permissions
               -> New Profile (if not already created)"
      },
      {
        name: "client_secret",
        label: "Client Secret",
        control_type: "password",
        optional: false,
        hint: "Your client secret can be found from Account
               -> Access Permissions -> New Profile (if not already created)"
      }
    ],

    authorization: {
      type: "custom_auth",

      acquire: lambda do |connection|
        {
          auth_token:
          post("https://#{connection['subdomain']}.caspio.com/oauth/token").
          payload(client_id: connection["client_id"],
                  client_secret: connection["client_secret"],
                  grant_type: "client_credentials").
          request_format_www_form_urlencoded.
          dig("access_token")
        }
      end,

      refresh_on: [401],

      detect_on: [/"Success"\S*\:\s*false/],

      apply: lambda do |connection|
        headers("Authorization": "Bearer #{connection['auth_token']}")
      end
    },
    base_uri: lambda do |connection|
      "https://#{connection['subdomain']}.caspio.com"
    end
  },

  test: lambda do |connection|
    get("/rest/v1/applications")
  end,

  object_definitions: {
    input_columns: {
      fields: lambda do |_connection, config|
        table = "#{config['table_name']}"
        columns = get("/rest/v1/tables/#{config['table_name']}/columns").
        dig("Result")&.
        reject{ |col| ["RANDOM ID", "AUTONUMBER", "PREFIXED AUTONUMBER",
                       "GUID", "TIMESTAMP"].include?(col["Type"]) }.
        map do |col|
          case col["Type"]
          when "STRING"
            { name: col["Name"],
              type: "string",
              control_type: "text",
              label: col["Name"].labelize,
              hint: col["Description"] }
          when "TEXT"
            { name: col["Name"],
              type: "string",
              control_type: "text-area",
              label: col["Name"].labelize,
              hint: col["Description"] }
          when "NUMBER"
            { name: col["Name"],
              type: "number",
              control_type: "number",
              label: col["Name"].labelize,
              hint: col["Description"] }
          when "DATE/TIME"
            { name: col["Name"],
              type: "date_time",
              control_type: "date_time",
              label: col["Name"].labelize,
              hint: col["Description"] }
          when "INTEGER"
            { name: col["Name"],
              type: "integer",
              control_type: "number",
              label: col["Name"].labelize,
              hint: col["Description"] }
          when "CURRENCY"
            { name: col["Name"],
              type: "number",
              control_type: "number",
              label: col["Name"].labelize,
              hint: col["Description"] }
          when "YES/NO"
            { name: col["Name"],
              type: "boolean",
              control_type: "checkbox",
              label: col["Name"].labelize,
              hint: col["Description"],
              toggle_hint: "Select from list",
              toggle_field:
                { name: col["Name"],
                  label: col["Name"].labelize,
                  type: :string,
                  control_type: "text",
                  optional: true,
                  toggle_hint: "Use custom value" } }
          when "PASSWORD"
            { name: col["Name"],
              type: "string",
              control_type: "password",
              label: col["Name"].labelize,
              hint: col["Description"] }
          when "TIMESTAMP"
            { name: col["Name"],
              type: "timestamp",
              control_type: "date_time",
              label: col["Name"].labelize,
              hint: col["Description"] }
#           when "RANDOM ID"
#             { name: col["Name"], type: "string",
#               control_type: "string", label: col["Name"].labelize,
#               hint: col["Description"] }
#           when "AUTONUMBER"
#             { name: col["Name"], type: "number",
#               control_type: "number", label: col["Name"].labelize,
#               hint: col["Description"] }
#           when "PREFIXED AUTONUMBER"
#             { name: col["Name"], type: "number",
#               control_type: "number", label: col["Name"].labelize,
#               hint: col["Description"] }
#           when "GUID"
#             { name: col["Name"], type: "string",
#               control_type: "string", label: col["Name"].labelize,
#               hint: col["Description"] }
          when "LIST-STRING"
            options = get("/rest/v1/tables/" + table + "/columns/" +
                      col["Name"]).dig("Result","ListOptions").
                      map do |key, val|
              [val.to_s, key.to_s]
            end
            { name: col["Name"],
              control_type: "multiselect",
              label: col["Name"].labelize,
              pick_list: options,
              pick_list_params: {},
              delimiter: ",",
              hint: col["Description"] }
          when "LIST-NUMBER"
            options = get("/rest/v1/tables/" + table +"/columns/" +
                      col["Name"]).dig("Result","ListOptions").
                      map do |key, val|
              [val.to_s, key.to_s]
            end
            { name: col["Name"],
              control_type: "multiselect",
              label: col["Name"].labelize,
              pick_list: options,
              pick_list_params: {},
              delimiter: ",",
              hint: col["Description"] }
          when "LIST-DATE/TIME"
            options = get("/rest/v1/tables/" + table +"/columns/" +
                      col["Name"]).dig("Result","ListOptions").
                      map do |key, val|
              [val.to_s, key.to_s]
            end
            { name: col["Name"],
              control_type: "multiselect",
              label: col["Name"].labelize,
              pick_list: options,
              pick_list_params: {},
              delimiter: ",",
              hint: col["Description"] }
          else
            { name: col["Name"],
              type: "string",
              control_type: "string",
              label: col["Name"].labelize,
              hint: col["Description"] }
          end
        end
      end
    },

    output_columns: {
      fields: lambda do |_connection, config|
        columns = get("/rest/v1/tables/#{config['table_name']}/columns").
                  dig("Result").
                  map do |col|
                    case col["Type"]
                    when "STRING"
                      { name: col["Name"],
                        type: "string",
                        control_type: "text",
                        label: col["Name"].labelize,
                        hint: col["Description"] }
                    when "TEXT"
                      { name: col["Name"],
                        type: "string",
                        control_type: "text-area",
                        label: col["Name"].labelize,
                        hint: col["Description"] }
                    when "NUMBER"
                      { name: col["Name"],
                        type: "number",
                        control_type: "number",
                        label: col["Name"].labelize,
                        hint: col["Description"] }
                    when "DATE/TIME"
                      { name: col["Name"],
                        type: "date_time",
                        control_type: "date_time",
                        label: col["Name"].labelize,
                        hint: col["Description"] }
                    when "INTEGER"
                      { name: col["Name"],
                        type: "integer",
                        control_type: "number",
                        label: col["Name"].labelize,
                        hint: col["Description"] }
                    when "CURRENCY"
                      { name: col["Name"],
                        type: "number",
                        control_type: "number",
                        label: col["Name"].labelize,
                        hint: col["Description"] }
                    when "YES/NO"
                      { name: col["Name"],
                        type: "boolean",
                        control_type: "checkbox",
                        label: col["Name"].labelize,
                        hint: col["Description"],
                        toggle_hint: "Select from list",
                        toggle_field:
                          { name: col["Name"],
                            label: col["Name"].labelize,
                            type: :string,
                            control_type: "text",
                            optional: true,
                            toggle_hint: "Use custom value" } }
                    when "PASSWORD"
                      { name: col["Name"],
                        type: "string",
                        control_type: "password",
                        label: col["Name"].labelize,
                        hint: col["Description"] }
                    when "TIMESTAMP"
                      { name: col["Name"],
                        type: "timestamp",
                        control_type: "date_time",
                        label: col["Name"].labelize,
                        hint: col["Description"] }
                    when "RANDOM ID"
                      { name: col["Name"],
                        type: "string",
                        control_type: "string",
                        label: col["Name"].labelize,
                        hint: col["Description"] }
                    when "AUTONUMBER"
                      { name: col["Name"],
                        type: "number",
                        control_type: "number",
                        label: col["Name"].labelize,
                        hint: col["Description"] }
                    when "PREFIXED AUTONUMBER"
                      { name: col["Name"],
                        type: "number",
                        control_type: "number",
                        label: col["Name"].labelize,
                        hint: col["Description"] }
                    when "GUID"
                      { name: col["Name"],
                        type: "string",
                        control_type: "string",
                        label: col["Name"].labelize,
                        hint: col["Description"] }
                    when "LIST-STRING"
                      { name: col["Name"],
                        type: "object",
                        label: col["Name"].labelize,
                        properties: [
                          { name: col["Name"] }
                        ],
                        hint: col["Description"] }
                    when "LIST-NUMBER"
                      num_list = col.dig("ListOptions").map do |key, val|
                        [key, val.to_s]
                      end
                    { name: col["Name"],
                      type: "object",
                      label: col["Name"].labelize,
                      hint: col["Description"],
                      properties: [
                        { name: col["Name"],
                          type: "integer" }
                      ] }
                    when "LIST-DATE/TIME"
                      date_list = col.dig("ListOptions").map do |key, val|
                        [key, val]
                      end
                    { name: col["Name"],
                      type: "object",
                      label: col["Name"].labelize,
                      hint: col["Description"],
                      properties: [
                        { name: col["Name"],
                          type: "date_time" }
                      ] }
                    else
                      { name: col["Name"],
                        type: "string",
                        control_type: "string",
                        label: col["Name"].labelize,
                        hint: col["Description"] }
                    end
                  end
      end
    },

    search_columns: {
      fields: lambda do |_connection, config|
        columns = get("/rest/v1/tables/#{config['table_name']}/columns").
                  dig("Result").
                  select { |c|
                    %w(INTEGER STRING NUMBER GUID).
                      include?(c["Type"])
                  }.
                  map do |col|
                    case col["Type"]
                    when "STRING"
                      { name: col["Name"],
                        type: "string",
                        control_type: "text",
                        label: col["Name"].labelize,
                        hint: col["Description"] }
                    when "NUMBER"
                      { name: col["Name"],
                        type: "number",
                        control_type: "number",
                        label: col["Name"].labelize,
                        hint: col["Description"] }
                    when "INTEGER"
                      { name: col["Name"],
                        type: "integer",
                        control_type: "number",
                        label: col["Name"].labelize,
                        hint: col["Description"] }
                    when "GUID"
                      { name: col["Name"],
                        type: "string",
                        control_type: "string",
                        label: col["Name"].labelize,
                        hint: col["Description"] }
                    else
                      { name: col["Name"],
                        type: "string",
                        control_type: "string",
                        label: col["Name"].labelize,
                        hint: col["Description"] }
                    end
                  end
      end
    }
  },

  actions: {
    search_records: {
      subtitle: "Search records",
      description: "Search <span class='provider'>records</span> " \
      "in <span class='provider'>Caspio</span>",
      config_fields: [
        { name: "table_name", control_type: :select,
          pick_list: :table_list,
          label: "Table",
          hint: "Select table",
          optional: false }
      ],
      input_fields: lambda do |object_definitions|
        object_definitions["search_columns"]
      end,
      execute: lambda do |_connection, input|
        table = input.delete("table_name")
        query_params = []
        input.map do |key, val|
          query_params << key + "='" + val + "'"
        end
        query_string = query_params.smart_join(" or ")
        query = '{"where":"' + query_string + '"}'
        {
          records: get("/rest/v1/tables/" + table + "/rows").params(q: query).
            dig("Result")
        }
      end,
      output_fields: lambda do |object_definitions|
        [
          { name: "records", type: "array", of: "object", properties:
            object_definitions["output_columns"] }
        ]
      end,
      sample_output: lambda do |_connection, input|
        get("/rest/v1/tables/#{input['table_name']}/rows").dig("Result", 0) ||
          {}
      end
    },
    create_record: {
      subtitle: "Create record",
      description: "Create <span class='provider'>record</span> " \
      "in <span class='provider'>Caspio table</span>",
      config_fields: [
        { name: "table_name", control_type: :select,
          pick_list: :table_list,
          label: "Table",
          hint: "Select table",
          optional: false }
      ],
      input_fields: lambda do |object_definitions|
        object_definitions["input_columns"]
      end,
      execute: lambda do |_connection, input|
        table = input.delete("table_name")
        date_fields = get("/rest/v1/tables/" + table + "/columns").
                      dig("Result")&.
                      select { |col|
                        col["Name"] if ["DATE/TIME", "TIMESTAMP"].
                                       include?(col["Type"])
                      }.
                      map { |el| el["Name"] }
        payload = input.map do |key, val|
          if date_fields.include?(key)
            { key => val.to_time.utc.iso8601 }
          else
            { key => val }
          end
        end.inject(:merge)
        post("/rest/v1/tables/" + table + "/rows").payload(payload).
          dig("Result")
      end,
      output_fields: lambda do
        []
      end,
      sample_output: lambda do |_connection, _input|
        {}
      end
    },
    update_record: {
      subtitle: "Update record",
      description: "Update <span class='provider'>record</span> " \
      "in <span class='provider'>Caspio table</span>",
      help: "When you update list fields,
             at least one non-list field should be updated.",
      config_fields: [
        { name: "table_name", control_type: :select,
          pick_list: :table_list,
          label: "Table",
          hint: "Select table",
          optional: false },
        { name: "where",
          label: "Column Name",
          control_type: "select",
          pick_list: :table_where_clause,
          pick_list_params: { table: "table_name" },
          sticky: true,
          optional: false,
          hint: "Name of column to be updated" }
      ],
      input_fields: lambda do |object_definitions|
        [
          { name: "value", label: "Value",
            sticky: true,
            optional: false,
            hint: "Value to be updated into the column" }
        ].concat(object_definitions["input_columns"])
      end,
      execute: lambda do |_connection, input|
        table = input.delete("table_name")
        where = input.delete("where")
        value = input.delete("value")
        query = '{"where":"' + where + "='" + value + "'" + '"}'
        date_fields = get("/rest/v1/tables/" + table + "/columns").
                      dig("Result")&.
                      select { |col|
                        col["Name"] if ["DATE/TIME", "TIMESTAMP"].
                                       include?(col["Type"])
                      }.
                      map { |el| el["Name"] }
        list_fields = get("/rest/v1/tables/" + table + "/columns").
                      dig("Result")&.
                      select { |col|
                        col["Name"] if col["Type"].
                                       starts_with?("LIST")
                      }.
                      map { |el| el["Name"] }
        payload = input.map do |key, val|
          if date_fields.include?(key)
            { key => val.to_time.utc.iso8601 }
          elsif list_fields.include?(key)
            { key => val.split(",").map(&:to_i) }
          else
            { key => val }
          end
        end.inject(:merge)
        put("/rest/v1/tables/" + table + "/rows").
          headers("X-HTTP-Method-Override": "PUT").
          params(q: query).payload(payload).dig("Result")
      end,
      output_fields: lambda do
        [{ name: "RowsAffected", type: "integer" }]
      end,
      sample_output: lambda do |_connection, _input|
        { "RowsAffected": "1" }
      end
    }
  },

  triggers: {
    new_record: {
      description: "New <span class='provider'>record</span> in
                    <span class='provider'>Caspio table</span>",
      help: "Triggers when a new record has been created.",
      config_fields: [
        { name: "table_name", control_type: :select,
          pick_list: :table_list,
          label: "Table",
          hint: "Select table",
          optional: false }
      ],
      poll: lambda do |_connection, input, last_record_id|
        last_record_id ||= 0
        table = input.delete("table_name")
        columns = get("/rest/v1/tables/" + table + "/columns").dig("Result").
                  pluck("Name").smart_join(",")
        query = '{"select":"PK_ID,' + columns + '","where":"PK_ID>' +
                last_record_id + '"}'
        records = get("/rest/v1/tables/" + table + "/rows").params(q: query).
                  dig("Result")
        last_record_id = records.last["PK_ID"] unless records.blank?
        { events: records,
          next_poll: last_record_id,
          can_poll_more: records.present? }
      end,
      dedup: lambda do |object|
        object["PK_ID"]
      end,
      output_fields: lambda do |object_definitions|
        [
          { name: "PK_ID", type: "number", label: "Primarykey ID" }
        ].concat(object_definitions["output_columns"])
      end,
      sample_output: lambda do |_connection, input|
        get("/rest/v1/tables/#{input['table_name']}/rows").dig("Result", 0) ||
          {}
      end
    }
  },

  pick_lists: {
    table_list: lambda do
      get("/rest/v1/tables").dig("Result").map do |a|
        [a.labelize, a]
      end
    end,
    table_where_clause: lambda do |_connection, table:|
      get("/rest/v1/tables/" + table + "/columns").dig("Result")&.
      select { |col| col unless col["Unique"] == false }.map do |col|
        [col["Name"].labelize, col["Name"]]
      end
    end,
    list_options: lambda do |_connection, table:, column:|
      get("/rest/v1/tables/" + table + "/columns/" + column).
        dig("Result", "ListOptions").map do |key, val|
        [val.to_s, key]
      end
    end
  }
}
