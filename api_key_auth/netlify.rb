{
  title: 'Netlify',

  connection: {
    fields: [
      {
        name: 'api_token',
        control_type: 'password'
        }
      ],

    authorization: {
      type: 'api_key',
      credentials: ->(connection) {
        headers(
          Authorization: "Bearer #{connection['api_token']}"
          )
        }
      }
    },

  test: ->(connection) {
    # List all sites to test if API token and connection are valid
    get("https://api.netlify.com/api/v1/sites")
    },

  object_definitions: {
    form: {
      fields: ->() {
        [
          {
            control_type: "text",
            label: "ID",
            type: "string",
            name: "id"
            },
          {
            control_type: "text",
            label: "Site ID",
            type: "string",
            name: "site_id"
            },
          {
            control_type: "text",
            label: "Name",
            type: "string",
            name: "name"
            },
          {
            name: "paths",
            type: "array",
            of: "string",
            control_type: "text",
            label: "Paths"
            },
          {
            control_type: "number",
            label: "Submission count",
            parse_output: "float_conversion",
            type: "number",
            name: "submission_count"
            },
          {
            name: "fields",
            type: "array",
            of: "object",
            label: "Fields",
            properties: [
              {
                control_type: "text",
                label: "Name",
                type: "string",
                name: "name"
                },
              {
                control_type: "text",
                label: "Type",
                type: "string",
                name: "type"
                }
              ]
            },
          {
            control_type: "text",
            label: "Created at",
            render_input: "date_time_conversion",
            parse_output: "date_time_conversion",
            type: "date_time",
            name: "created_at"
            }
          ]}
      },
    submission: {
      fields: ->() {
        [
          {
            control_type: "text",
            label: "ID",
            type: "string",
            name: "id"
            },
          {
            control_type: "number",
            label: "Number",
            parse_output: "float_conversion",
            type: "number",
            name: "number"
            },
          {
            control_type: "text",
            label: "Title",
            type: "string",
            name: "title"
            },
          {
            control_type: "text",
            label: "Email",
            type: "string",
            name: "email"
            },
          {
            control_type: "text",
            label: "Name",
            type: "string",
            name: "name"
            },
          {
            control_type: "text",
            label: "First name",
            type: "string",
            name: "first_name"
            },
          {
            control_type: "text",
            label: "Last name",
            type: "string",
            name: "last_name"
            },
          {
            control_type: "text",
            label: "Company",
            type: "string",
            name: "company"
            },
          {
            control_type: "text",
            label: "Summary",
            type: "string",
            name: "summary"
            },
          {
            control_type: "text",
            label: "Body",
            type: "string",
            name: "body"
            },
          {
            properties: [
              {
                control_type: "text",
                label: "Email",
                type: "string",
                name: "email"
                },
              {
                control_type: "text",
                label: "Name",
                type: "string",
                name: "name"
                },
              {
                control_type: "text",
                label: "Ip",
                type: "string",
                name: "ip"
                }
              ],
            label: "Data",
            type: "object",
            name: "data"
            },
          {
            control_type: "text",
            label: "Created at",
            render_input: "date_time_conversion",
            parse_output: "date_time_conversion",
            type: "date_time",
            name: "created_at"
            },
          {
            control_type: "text",
            label: "Site URL",
            type: "string",
            name: "site_url"
            }
          ]}
      },
    site: {
      #       Provide a preview user to display in the recipe data tree.
      preview: ->(connection) {
        get("https://api.netlify.com/api/v1/sites").first
        },
      fields: ->() {
        [
          {
            control_type: "text",
            label: "ID",
            type: "string",
            name: "id"
            },
          {
            control_type: "text",
            label: "Site ID",
            type: "string",
            name: "site_id"
            },
          {
            control_type: "text",
            label: "Plan",
            type: "string",
            name: "plan"
            },
          {
            properties: [
              {
                control_type: "text",
                label: "Title",
                type: "string",
                name: "title"
                },
              {
                control_type: "text",
                label: "Asset acceleration",
                render_input: {},
                parse_output: {},
                toggle_hint: "Select from option list",
                toggle_field: {
                  label: "Asset acceleration",
                  control_type: "text",
                  toggle_hint: "Use custom value",
                  type: "boolean",
                  name: "asset_acceleration"
                  },
                type: "boolean",
                name: "asset_acceleration"
                },
              {
                control_type: "text",
                label: "Form processing",
                render_input: {},
                parse_output: {},
                toggle_hint: "Select from option list",
                toggle_field: {
                  label: "Form processing",
                  control_type: "text",
                  toggle_hint: "Use custom value",
                  type: "boolean",
                  name: "form_processing"
                  },
                type: "boolean",
                name: "form_processing"
                },
              {
                control_type: "text",
                label: "Cdn propagation",
                type: "string",
                name: "cdn_propagation"
                },
              {
                control_type: "text",
                label: "Build gc exchange",
                type: "string",
                name: "build_gc_exchange"
                },
              {
                control_type: "text",
                label: "Build node pool",
                type: "string",
                name: "build_node_pool"
                },
              {
                control_type: "text",
                label: "Build cluster",
                type: "string",
                name: "build_cluster"
                },
              {
                control_type: "text",
                label: "Domain aliases",
                render_input: {},
                parse_output: {},
                toggle_hint: "Select from option list",
                toggle_field: {
                  label: "Domain aliases",
                  control_type: "text",
                  toggle_hint: "Use custom value",
                  type: "boolean",
                  name: "domain_aliases"
                  },
                type: "boolean",
                name: "domain_aliases"
                },
              {
                control_type: "text",
                label: "Secure site",
                render_input: {},
                parse_output: {},
                toggle_hint: "Select from option list",
                toggle_field: {
                  label: "Secure site",
                  control_type: "text",
                  toggle_hint: "Use custom value",
                  type: "boolean",
                  name: "secure_site"
                  },
                type: "boolean",
                name: "secure_site"
                },
              {
                control_type: "text",
                label: "Prerendering",
                render_input: {},
                parse_output: {},
                toggle_hint: "Select from option list",
                toggle_field: {
                  label: "Prerendering",
                  control_type: "text",
                  toggle_hint: "Use custom value",
                  type: "boolean",
                  name: "prerendering"
                  },
                type: "boolean",
                name: "prerendering"
                },
              {
                control_type: "text",
                label: "Proxying",
                render_input: {},
                parse_output: {},
                toggle_hint: "Select from option list",
                toggle_field: {
                  label: "Proxying",
                  control_type: "text",
                  toggle_hint: "Use custom value",
                  type: "boolean",
                  name: "proxying"
                  },
                type: "boolean",
                name: "proxying"
                },
              {
                control_type: "text",
                label: "Ssl",
                type: "string",
                name: "ssl"
                },
              {
                control_type: "number",
                label: "Rate cents",
                parse_output: "float_conversion",
                type: "number",
                name: "rate_cents"
                },
              {
                control_type: "number",
                label: "Yearly rate cents",
                parse_output: "float_conversion",
                type: "number",
                name: "yearly_rate_cents"
                },
              {
                control_type: "text",
                label: "Cdn network",
                type: "string",
                name: "cdn_network"
                },
              {
                control_type: "text",
                label: "Branch deploy",
                render_input: {},
                parse_output: {},
                toggle_hint: "Select from option list",
                toggle_field: {
                  label: "Branch deploy",
                  control_type: "text",
                  toggle_hint: "Use custom value",
                  type: "boolean",
                  name: "branch_deploy"
                  },
                type: "boolean",
                name: "branch_deploy"
                },
              {
                control_type: "text",
                label: "Managed dns",
                render_input: {},
                parse_output: {},
                toggle_hint: "Select from option list",
                toggle_field: {
                  label: "Managed dns",
                  control_type: "text",
                  toggle_hint: "Use custom value",
                  type: "boolean",
                  name: "managed_dns"
                  },
                type: "boolean",
                name: "managed_dns"
                },
              {
                control_type: "text",
                label: "Geo ip",
                render_input: {},
                parse_output: {},
                toggle_hint: "Select from option list",
                toggle_field: {
                  label: "Geo ip",
                  control_type: "text",
                  toggle_hint: "Use custom value",
                  type: "boolean",
                  name: "geo_ip"
                  },
                type: "boolean",
                name: "geo_ip"
                },
              {
                control_type: "text",
                label: "Split testing",
                render_input: {},
                parse_output: {},
                toggle_hint: "Select from option list",
                toggle_field: {
                  label: "Split testing",
                  control_type: "text",
                  toggle_hint: "Use custom value",
                  type: "boolean",
                  name: "split_testing"
                  },
                type: "boolean",
                name: "split_testing"
                },
              {
                control_type: "text",
                label: "ID",
                type: "string",
                name: "id"
                }
              ],
            label: "Plan data",
            type: "object",
            name: "plan_data"
            },
          {
            control_type: "text",
            label: "Ssl plan",
            type: "string",
            name: "ssl_plan"
            },
          {
            control_type: "text",
            label: "Premium",
            render_input: {},
            parse_output: {},
            toggle_hint: "Select from option list",
            toggle_field: {
              label: "Premium",
              control_type: "text",
              toggle_hint: "Use custom value",
              type: "boolean",
              name: "premium"
              },
            type: "boolean",
            name: "premium"
            },
          {
            control_type: "text",
            label: "Claimed",
            render_input: {},
            parse_output: {},
            toggle_hint: "Select from option list",
            toggle_field: {
              label: "Claimed",
              control_type: "text",
              toggle_hint: "Use custom value",
              type: "boolean",
              name: "claimed"
              },
            type: "boolean",
            name: "claimed"
            },
          {
            control_type: "text",
            label: "Name",
            type: "string",
            name: "name"
            },
          {
            control_type: "text",
            label: "Custom domain",
            type: "string",
            name: "custom_domain"
            },
          {
            control_type: "text",
            label: "Password",
            type: "string",
            name: "password"
            },
          {
            control_type: "text",
            label: "Notification email",
            type: "string",
            name: "notification_email"
            },
          {
            control_type: "text",
            label: "URL",
            type: "string",
            name: "url"
            },
          {
            control_type: "text",
            label: "Admin URL",
            type: "string",
            name: "admin_url"
            },
          {
            control_type: "text",
            label: "Deploy ID",
            type: "string",
            name: "deploy_id"
            },
          {
            control_type: "text",
            label: "Build ID",
            type: "string",
            name: "build_id"
            },
          {
            control_type: "text",
            label: "Deploy URL",
            type: "string",
            name: "deploy_url"
            },
          {
            control_type: "text",
            label: "State",
            type: "string",
            name: "state"
            },
          {
            control_type: "text",
            label: "Screenshot URL",
            type: "string",
            name: "screenshot_url"
            },
          {
            control_type: "text",
            label: "Created at",
            render_input: "date_time_conversion",
            parse_output: "date_time_conversion",
            type: "date_time",
            name: "created_at"
            },
          {
            control_type: "text",
            label: "Updated at",
            render_input: "date_time_conversion",
            parse_output: "date_time_conversion",
            type: "date_time",
            name: "updated_at"
            },
          {
            control_type: "text",
            label: "User ID",
            type: "string",
            name: "user_id"
            },
          {
            control_type: "text",
            label: "Error message",
            type: "string",
            name: "error_message"
            },
          {
            control_type: "text",
            label: "Ssl",
            render_input: {},
            parse_output: {},
            toggle_hint: "Select from option list",
            toggle_field: {
              label: "Ssl",
              control_type: "text",
              toggle_hint: "Use custom value",
              type: "boolean",
              name: "ssl"
              },
            type: "boolean",
            name: "ssl"
            },
          {
            control_type: "text",
            label: "Ssl URL",
            type: "string",
            name: "ssl_url"
            },
          {
            control_type: "text",
            label: "Force ssl",
            type: "string",
            name: "force_ssl"
            },
          {
            control_type: "text",
            label: "Ssl status",
            type: "string",
            name: "ssl_status"
            },
          {
            control_type: "number",
            label: "Max domain aliases",
            parse_output: "float_conversion",
            type: "number",
            name: "max_domain_aliases"
            },
          {
            properties: [
              {
                control_type: "text",
                label: "Cmd",
                type: "string",
                name: "cmd"
                },
              {
                control_type: "text",
                label: "Dir",
                type: "string",
                name: "dir"
                },
              {
                properties: [],
                label: "Env",
                type: "object",
                name: "env"
                },
              {
                control_type: "text",
                label: "Created at",
                render_input: "date_time_conversion",
                parse_output: "date_time_conversion",
                type: "date_time",
                name: "created_at"
                },
              {
                control_type: "text",
                label: "Updated at",
                render_input: "date_time_conversion",
                parse_output: "date_time_conversion",
                type: "date_time",
                name: "updated_at"
                },
              {
                control_type: "text",
                label: "Public repo",
                render_input: {},
                parse_output: {},
                toggle_hint: "Select from option list",
                toggle_field: {
                  label: "Public repo",
                  control_type: "text",
                  toggle_hint: "Use custom value",
                  type: "boolean",
                  name: "public_repo"
                  },
                type: "boolean",
                name: "public_repo"
                },
              {
                control_type: "text",
                label: "Private logs",
                type: "string",
                name: "private_logs"
                },
              {
                name: "allowed_branches",
                type: "array",
                of: "string",
                label: "Allowed branches"
                },
              {
                control_type: "text",
                label: "Functions dir",
                type: "string",
                name: "functions_dir"
                },
              {
                control_type: "text",
                label: "Provider",
                type: "string",
                name: "provider"
                },
              {
                control_type: "text",
                label: "Repo type",
                type: "string",
                name: "repo_type"
                },
              {
                control_type: "text",
                label: "Repo URL",
                type: "string",
                name: "repo_url"
                },
              {
                control_type: "text",
                label: "Repo branch",
                type: "string",
                name: "repo_branch"
                },
              {
                control_type: "text",
                label: "Repo path",
                type: "string",
                name: "repo_path"
                },
              {
                control_type: "text",
                label: "Base",
                type: "string",
                name: "base"
                },
              {
                control_type: "text",
                label: "Deploy key ID",
                type: "string",
                name: "deploy_key_id"
                }
              ],
            label: "Build settings",
            type: "object",
            name: "build_settings"
            },
          {
            properties: [
              {
                properties: [
                  {
                    control_type: "text",
                    label: "Bundle",
                    render_input: {},
                    parse_output: {},
                    toggle_hint: "Select from option list",
                    toggle_field: {
                      label: "Bundle",
                      control_type: "text",
                      toggle_hint: "Use custom value",
                      type: "boolean",
                      name: "bundle"
                      },
                    type: "boolean",
                    name: "bundle"
                    },
                  {
                    control_type: "text",
                    label: "Minify",
                    render_input: {},
                    parse_output: {},
                    toggle_hint: "Select from option list",
                    toggle_field: {
                      label: "Minify",
                      control_type: "text",
                      toggle_hint: "Use custom value",
                      type: "boolean",
                      name: "minify"
                      },
                    type: "boolean",
                    name: "minify"
                    }
                  ],
                label: "Css",
                type: "object",
                name: "css"
                },
              {
                properties: [
                  {
                    control_type: "text",
                    label: "Bundle",
                    render_input: {},
                    parse_output: {},
                    toggle_hint: "Select from option list",
                    toggle_field: {
                      label: "Bundle",
                      control_type: "text",
                      toggle_hint: "Use custom value",
                      type: "boolean",
                      name: "bundle"
                      },
                    type: "boolean",
                    name: "bundle"
                    },
                  {
                    control_type: "text",
                    label: "Minify",
                    render_input: {},
                    parse_output: {},
                    toggle_hint: "Select from option list",
                    toggle_field: {
                      label: "Minify",
                      control_type: "text",
                      toggle_hint: "Use custom value",
                      type: "boolean",
                      name: "minify"
                      },
                    type: "boolean",
                    name: "minify"
                    }
                  ],
                label: "Js",
                type: "object",
                name: "js"
                },
              {
                properties: [
                  {
                    control_type: "text",
                    label: "Optimize",
                    render_input: {},
                    parse_output: {},
                    toggle_hint: "Select from option list",
                    toggle_field: {
                      label: "Optimize",
                      control_type: "text",
                      toggle_hint: "Use custom value",
                      type: "boolean",
                      name: "optimize"
                      },
                    type: "boolean",
                    name: "optimize"
                    }
                  ],
                label: "Images",
                type: "object",
                name: "images"
                },
              {
                properties: [
                  {
                    control_type: "text",
                    label: "Pretty urls",
                    render_input: {},
                    parse_output: {},
                    toggle_hint: "Select from option list",
                    toggle_field: {
                      label: "Pretty urls",
                      control_type: "text",
                      toggle_hint: "Use custom value",
                      type: "boolean",
                      name: "pretty_urls"
                      },
                    type: "boolean",
                    name: "pretty_urls"
                    }
                  ],
                label: "Html",
                type: "object",
                name: "html"
                },
              {
                control_type: "text",
                label: "Skip",
                render_input: {},
                parse_output: {},
                toggle_hint: "Select from option list",
                toggle_field: {
                  label: "Skip",
                  control_type: "text",
                  toggle_hint: "Use custom value",
                  type: "boolean",
                  name: "skip"
                  },
                type: "boolean",
                name: "skip"
                }
              ],
            label: "Processing settings",
            type: "object",
            name: "processing_settings"
            },
          {
            control_type: "text",
            label: "Prerender",
            type: "string",
            name: "prerender"
            },
          {
            control_type: "text",
            label: "Prerender headers",
            type: "string",
            name: "prerender_headers"
            },
          {
            control_type: "text",
            label: "Deploy hook",
            type: "string",
            name: "deploy_hook"
            },
          {
            control_type: "text",
            label: "Published deploy",
            type: "string",
            name: "published_deploy"
            },
          {
            control_type: "text",
            label: "Managed dns",
            render_input: {},
            parse_output: {},
            toggle_hint: "Select from option list",
            toggle_field: {
              label: "Managed dns",
              control_type: "text",
              toggle_hint: "Use custom value",
              type: "boolean",
              name: "managed_dns"
              },
            type: "boolean",
            name: "managed_dns"
            },
          {
            control_type: "text",
            label: "Jwt secret",
            type: "string",
            name: "jwt_secret"
            },
          {
            control_type: "text",
            label: "Account slug",
            type: "string",
            name: "account_slug"
            },
          {
            control_type: "text",
            label: "Account name",
            type: "string",
            name: "account_name"
            },
          {
            control_type: "text",
            label: "Account type",
            type: "string",
            name: "account_type"
            },
          {
            properties: [
              {
                control_type: "text",
                label: "Title",
                type: "string",
                name: "title"
                },
              {
                control_type: "text",
                label: "Asset acceleration",
                render_input: {},
                parse_output: {},
                toggle_hint: "Select from option list",
                toggle_field: {
                  label: "Asset acceleration",
                  control_type: "text",
                  toggle_hint: "Use custom value",
                  type: "boolean",
                  name: "asset_acceleration"
                  },
                type: "boolean",
                name: "asset_acceleration"
                },
              {
                control_type: "text",
                label: "Form processing",
                render_input: {},
                parse_output: {},
                toggle_hint: "Select from option list",
                toggle_field: {
                  label: "Form processing",
                  control_type: "text",
                  toggle_hint: "Use custom value",
                  type: "boolean",
                  name: "form_processing"
                  },
                type: "boolean",
                name: "form_processing"
                },
              {
                control_type: "text",
                label: "Cdn propagation",
                type: "string",
                name: "cdn_propagation"
                },
              {
                control_type: "text",
                label: "Build gc exchange",
                type: "string",
                name: "build_gc_exchange"
                },
              {
                control_type: "text",
                label: "Build node pool",
                type: "string",
                name: "build_node_pool"
                },
              {
                control_type: "text",
                label: "Build cluster",
                type: "string",
                name: "build_cluster"
                },
              {
                control_type: "text",
                label: "Domain aliases",
                render_input: {},
                parse_output: {},
                toggle_hint: "Select from option list",
                toggle_field: {
                  label: "Domain aliases",
                  control_type: "text",
                  toggle_hint: "Use custom value",
                  type: "boolean",
                  name: "domain_aliases"
                  },
                type: "boolean",
                name: "domain_aliases"
                },
              {
                control_type: "text",
                label: "Secure site",
                render_input: {},
                parse_output: {},
                toggle_hint: "Select from option list",
                toggle_field: {
                  label: "Secure site",
                  control_type: "text",
                  toggle_hint: "Use custom value",
                  type: "boolean",
                  name: "secure_site"
                  },
                type: "boolean",
                name: "secure_site"
                },
              {
                control_type: "text",
                label: "Prerendering",
                render_input: {},
                parse_output: {},
                toggle_hint: "Select from option list",
                toggle_field: {
                  label: "Prerendering",
                  control_type: "text",
                  toggle_hint: "Use custom value",
                  type: "boolean",
                  name: "prerendering"
                  },
                type: "boolean",
                name: "prerendering"
                },
              {
                control_type: "text",
                label: "Proxying",
                render_input: {},
                parse_output: {},
                toggle_hint: "Select from option list",
                toggle_field: {
                  label: "Proxying",
                  control_type: "text",
                  toggle_hint: "Use custom value",
                  type: "boolean",
                  name: "proxying"
                  },
                type: "boolean",
                name: "proxying"
                },
              {
                control_type: "text",
                label: "Ssl",
                type: "string",
                name: "ssl"
                },
              {
                control_type: "number",
                label: "Rate cents",
                parse_output: "float_conversion",
                type: "number",
                name: "rate_cents"
                },
              {
                control_type: "number",
                label: "Yearly rate cents",
                parse_output: "float_conversion",
                type: "number",
                name: "yearly_rate_cents"
                },
              {
                control_type: "text",
                label: "Cdn network",
                type: "string",
                name: "cdn_network"
                },
              {
                control_type: "text",
                label: "Branch deploy",
                render_input: {},
                parse_output: {},
                toggle_hint: "Select from option list",
                toggle_field: {
                  label: "Branch deploy",
                  control_type: "text",
                  toggle_hint: "Use custom value",
                  type: "boolean",
                  name: "branch_deploy"
                  },
                type: "boolean",
                name: "branch_deploy"
                },
              {
                control_type: "text",
                label: "Managed dns",
                render_input: {},
                parse_output: {},
                toggle_hint: "Select from option list",
                toggle_field: {
                  label: "Managed dns",
                  control_type: "text",
                  toggle_hint: "Use custom value",
                  type: "boolean",
                  name: "managed_dns"
                  },
                type: "boolean",
                name: "managed_dns"
                },
              {
                control_type: "text",
                label: "Geo ip",
                render_input: {},
                parse_output: {},
                toggle_hint: "Select from option list",
                toggle_field: {
                  label: "Geo ip",
                  control_type: "text",
                  toggle_hint: "Use custom value",
                  type: "boolean",
                  name: "geo_ip"
                  },
                type: "boolean",
                name: "geo_ip"
                },
              {
                control_type: "text",
                label: "Split testing",
                render_input: {},
                parse_output: {},
                toggle_hint: "Select from option list",
                toggle_field: {
                  label: "Split testing",
                  control_type: "text",
                  toggle_hint: "Use custom value",
                  type: "boolean",
                  name: "split_testing"
                  },
                type: "boolean",
                name: "split_testing"
                },
              {
                control_type: "text",
                label: "ID",
                type: "string",
                name: "id"
                }
              ],
            label: "Capabilities",
            type: "object",
            name: "capabilities"
            },
          {
            control_type: "text",
            label: "External contributors enabled",
            render_input: {},
            parse_output: {},
            toggle_hint: "Select from option list",
            toggle_field: {
              label: "External contributors enabled",
              control_type: "text",
              toggle_hint: "Use custom value",
              type: "boolean",
              name: "external_contributors_enabled"
              },
            type: "boolean",
            name: "external_contributors_enabled"
            },
          {
            control_type: "text",
            label: "Paid individual site subscription",
            type: "string",
            name: "paid_individual_site_subscription"
            },
          {
            control_type: "text",
            label: "Dns zone ID",
            type: "string",
            name: "dns_zone_id"
            },
          {
            control_type: "text",
            label: "Identity instance ID",
            type: "string",
            name: "identity_instance_id"
            },
          {
            control_type: "text",
            label: "Use functions",
            type: "string",
            name: "use_functions"
            },
          {
            control_type: "text",
            label: "Parent user ID",
            type: "string",
            name: "parent_user_id"
            }
          ]
        }
      },
    deploy: {
      fields: ->() {
        [
          {
            control_type: "text",
            label: "ID",
            type: "string",
            name: "id"
            },
          {
            control_type: "text",
            label: "Site ID",
            type: "string",
            name: "site_id"
            },
          {
            control_type: "text",
            label: "Build ID",
            type: "string",
            name: "build_id"
            },
          {
            control_type: "text",
            label: "State",
            type: "string",
            name: "state"
            },
          {
            control_type: "text",
            label: "Name",
            type: "string",
            name: "name"
            },
          {
            control_type: "text",
            label: "URL",
            type: "string",
            name: "url"
            },
          {
            control_type: "text",
            label: "Ssl URL",
            type: "string",
            name: "ssl_url"
            },
          {
            control_type: "text",
            label: "Admin URL",
            type: "string",
            name: "admin_url"
            },
          {
            control_type: "text",
            label: "Deploy URL",
            type: "string",
            name: "deploy_url"
            },
          {
            control_type: "text",
            label: "Deploy ssl URL",
            type: "string",
            name: "deploy_ssl_url"
            },
          {
            control_type: "text",
            label: "Screenshot URL",
            type: "string",
            name: "screenshot_url"
            },
          {
            control_type: "text",
            label: "Created at",
            render_input: "date_time_conversion",
            parse_output: "date_time_conversion",
            type: "date_time",
            name: "created_at"
            },
          {
            control_type: "text",
            label: "Updated at",
            render_input: "date_time_conversion",
            parse_output: "date_time_conversion",
            type: "date_time",
            name: "updated_at"
            },
          {
            control_type: "text",
            label: "User ID",
            type: "string",
            name: "user_id"
            },
          {
            control_type: "text",
            label: "Error message",
            type: "string",
            name: "error_message"
            },
          {
            control_type: "text",
            label: "Commit ref",
            type: "string",
            name: "commit_ref"
            },
          {
            control_type: "text",
            label: "Review ID",
            type: "string",
            name: "review_id"
            },
          {
            control_type: "text",
            label: "Branch",
            type: "string",
            name: "branch"
            },
          {
            control_type: "text",
            label: "Commit URL",
            type: "string",
            name: "commit_url"
            },
          {
            control_type: "text",
            label: "Skipped",
            type: "string",
            name: "skipped"
            },
          {
            control_type: "text",
            label: "Locked",
            render_input: {},
            parse_output: {},
            toggle_hint: "Select from option list",
            toggle_field: {
              label: "Locked",
              control_type: "text",
              toggle_hint: "Use custom value",
              type: "boolean",
              name: "locked"
              },
            type: "boolean",
            name: "locked"
            },
          {
            properties: [
              {
                control_type: "text",
                label: "Type",
                type: "string",
                name: "type"
                },
              {
                control_type: "text",
                label: "URL",
                type: "string",
                name: "url"
                }
              ],
            label: "Log access attributes",
            type: "object",
            name: "log_access_attributes"
            },
          {
            control_type: "text",
            label: "Title",
            type: "string",
            name: "title"
            },
          {
            control_type: "text",
            label: "Review URL",
            type: "string",
            name: "review_url"
            },
          {
            control_type: "text",
            label: "Published at",
            render_input: "date_time_conversion",
            parse_output: "date_time_conversion",
            type: "date_time",
            name: "published_at"
            },
          {
            control_type: "text",
            label: "Context",
            type: "string",
            name: "context"
            },
          {
            control_type: "number",
            label: "Deploy time",
            parse_output: "float_conversion",
            type: "number",
            name: "deploy_time"
            }
          ]
        }
      },
    hook: {
      fields: ->() {
        [
          {
            control_type: "text",
            label: "ID",
            type: "string",
            name: "id"
            },
          {
            control_type: "text",
            label: "Site ID",
            type: "string",
            name: "site_id"
            },
          {
            control_type: "text",
            label: "Form ID",
            type: "string",
            name: "form_id"
            },
          {
            control_type: "text",
            label: "Form name",
            type: "string",
            name: "form_name"
            },
          {
            control_type: "text",
            label: "User ID",
            type: "string",
            name: "user_id"
            },
          {
            properties: [
              {
                control_type: "text",
                label: "ID",
                type: "string",
                name: "id"
                },
              {
                control_type: "text",
                label: "Uid",
                type: "string",
                name: "uid"
                },
              {
                control_type: "text",
                label: "Full name",
                type: "string",
                name: "full_name"
                },
              {
                control_type: "text",
                label: "Avatar URL",
                type: "string",
                name: "avatar_url"
                },
              {
                control_type: "text",
                label: "Email",
                type: "string",
                name: "email"
                },
              {
                control_type: "text",
                label: "Affiliate ID",
                type: "string",
                name: "affiliate_id"
                },
              {
                control_type: "number",
                label: "Site count",
                parse_output: "float_conversion",
                type: "number",
                name: "site_count"
                },
              {
                control_type: "text",
                label: "Created at",
                render_input: "date_time_conversion",
                parse_output: "date_time_conversion",
                type: "date_time",
                name: "created_at"
                },
              {
                control_type: "text",
                label: "Last login",
                render_input: "date_time_conversion",
                parse_output: "date_time_conversion",
                type: "date_time",
                name: "last_login"
                },
              {
                name: "login_providers",
                type: "array",
                of: "string",
                label: "Login providers"
                },
              {
                properties: [
                  {
                    control_type: "text",
                    label: "Slides",
                    type: "string",
                    name: "slides"
                    }
                  ],
                label: "Onboarding progress",
                type: "object",
                name: "onboarding_progress"
                },
              {
                control_type: "number",
                label: "Support priority",
                parse_output: "float_conversion",
                type: "number",
                name: "support_priority"
                }
              ],
            label: "User",
            type: "object",
            name: "user"
            },
          {
            control_type: "text",
            label: "Type",
            type: "string",
            name: "type"
            },
          {
            control_type: "text",
            label: "Event",
            type: "string",
            name: "event"
            },
          {
            properties: [
              {
                control_type: "text",
                label: "Access token",
                type: "string",
                name: "access_token"
                },
              {
                control_type: "text",
                label: "Url",
                type: "string",
                name: "url"
                }
              ],
            label: "Data",
            type: "object",
            name: "data"
            },
          {
            control_type: "text",
            label: "Success",
            type: "string",
            name: "success"
            },
          {
            control_type: "text",
            label: "Created at",
            render_input: "date_time_conversion",
            parse_output: "date_time_conversion",
            type: "date_time",
            name: "created_at"
            },
          {
            control_type: "text",
            label: "Updated at",
            render_input: "date_time_conversion",
            parse_output: "date_time_conversion",
            type: "date_time",
            name: "updated_at"
            },
          {
            control_type: "text",
            label: "Actor",
            type: "string",
            name: "actor"
            },
          {
            control_type: "text",
            label: "Disabled",
            type: "string",
            name: "disabled"
            }
          ]
        }
      },
    hook_type: {
      fields: ->() {
        [
          {
            control_type: "text",
            label: "Name",
            type: "string",
            name: "name"
            },
          {
            name: "fields",
            type: "array",
            of: "object",
            label: "Fields",
            properties: [
              {
                control_type: "text",
                label: "Name",
                type: "string",
                name: "name"
                },
              {
                properties: [
                  {
                    control_type: "text",
                    label: "Type",
                    type: "string",
                    name: "type"
                    },
                  {
                    control_type: "text",
                    label: "Title",
                    type: "string",
                    name: "title"
                    }
                  ],
                label: "Options",
                type: "object",
                name: "options"
                }
              ]
            },
          {
            name: "events",
            type: "array",
            of: "string",
            control_type: "text",
            label: "Events"
            }
          ]
        }
      }
    },

  actions: {
    #     test: {
    #       input_fields: ->(object_definitions) {[]},

    #       execute: ->(connection, input) {
    #         hook_type = nil
    #         get("https://api.netlify.com/api/v1/hooks/types").each do |ht|
    #           if ht["name"]="url"
    #             hook_type = ht
    #           end
    #         end
    #         puts hook_type["events"]
    #         #             ["events"].map{ |et| [et, et] }
    #         },

    #       output_fields: ->(object_definitions) {[]}
    #       },
    get_site_details: {
      input_fields: ->(object_definitions) {
        [{
          name: "id",
          label: "Site Name",
          optional: false,
          type: "string",
          control_type: "select",
          pick_list: "sites",
          toggle_hint: "Use Site Name",
          toggle_field: {
            name: "id",
            label: "Site ID",
            type: "string",
            optional: false,
            control_type: "text",
            toggle_hint: "Use Site ID"
            }
          }]
        },

      execute: ->(connection, input) {
        { site: get("https://api.netlify.com/api/v1/sites/#{input["id"]}") }
        },

      output_fields: ->(object_definitions) {
        [
          {
            name: "site",
            label: "Site",
            type: "object",
            properties: object_definitions["site"]
            }
          ]
        }
      },
    get_deploy_details: {
      input_fields: ->(object_definitions) {
        [{
          name: "id",
          label: "Deploy ID",
          optional: false,
          type: "string"
          }]
        },

      execute: ->(connection, input) {
        { deploy: get("https://api.netlify.com/api/v1/deploys/#{input["id"]}") }
        },

      output_fields: ->(object_definitions) {
        [
          {
            name: "deploy",
            label: "Deploy",
            type: "object",
            properties: object_definitions["deploy"]
            }
          ]
        }
      },
    get_form_submission: {
      input_fields: ->(object_definitions) {
        [
          {
            name: "id",
            label: "Submission ID",
            optional: false,
            type: "string"
            }
          ]
        },

      execute: ->(connection, input) {
        { deploy: get("https://api.netlify.com/api/v1/submissions/
            #{input["id"]}") }
        },

      output_fields: ->(object_definitions) {
        [
          {
            name: "submission",
            label: "Submission",
            type: "object",
            properties: object_definitions["submission"]
            }
          ]
        }
      },
    list_form_submissions: {
      input_fields: ->(object_definitions) {
        [
          {
            name: "id",
            label: "Site Name",
            optional: false,
            type: "string",
            control_type: "select",
            pick_list: "sites",
            toggle_hint: "Use Site Name",
            toggle_field: {
              name: "id",
              label: "Site ID",
              type: "string",
              optional: false,
              control_type: "text",
              toggle_hint: "Use Site ID"
              }
            }
          ]
        },

      execute: ->(connection, input) {
        { submissions: get("https://api.netlify.com/api/v1/sites/#{input["id"]}/submissions") }
        },

      output_fields: ->(object_definitions) {
        [
          {
            name: "submissions",
            label: "Submissions",
            type: "array",
            of: "object",
            properties: object_definitions["submission"]
            }
          ]
        }
      },
    delete_form_submission: {
      input_fields: ->(object_definitions) {
        [
          {
            name: "id",
            label: "Submission ID",
            optional: false,
            type: "string"
            }
          ]
        },

      execute: ->(connection, input) {
        delete("https://api.netlify.com/api/v1/submissions/#{input["id"]}")
        },

      output_fields: ->(object_definitions) {[]}
      },
    restore_deploy: {
      input_fields: ->(object_definitions) {
        [
          {
            name: "site_id",
            label: "Site Name",
            optional: false,
            type: "string",
            control_type: "select",
            pick_list: "sites",
            toggle_hint: "Use Site Name",
            toggle_field: {
              name: "site_id",
              label: "Site ID",
              type: "string",
              optional: false,
              control_type: "text",
              toggle_hint: "Use Site ID"
              }
            },
          {
            name: "deploy_id",
            label: "Deploy ID",
            optional: false,
            type: "string"
            }
          ]
        },

      execute: ->(connection, input) {
        post("https://api.netlify.com/api/v1/sites/
          #{input["site_id"]}/deploys/#{input["deploy_id"]}/restore")
        },

      output_fields: ->(object_definitions) {
        object_definitions["deploy"]
        }
      },
    unlock_deploy: {
      input_fields: ->(object_definitions) {
        [
          {
            name: "deploy_id",
            label: "Deploy ID",
            optional: false,
            type: "string"
            }
          ]
        },

      execute: ->(connection, input) {
        post("https://api.netlify.com/api/v1/deploys/
          #{input["deploy_id"]}/unlock")
        },

      output_fields: ->(object_definitions) {
        object_definitions["deploy"]
        }
      },
    lock_deploy: {
      input_fields: ->(object_definitions) {
        [
          {
            name: "deploy_id",
            label: "Deploy ID",
            optional: false,
            type: "string"
            }
          ]
        },

      execute: ->(connection, input) {
        post("https://api.netlify.com/api/v1/deploys/#{input["deploy_id"]}/lock")
        },

      output_fields: ->(object_definitions) {
        object_definitions["deploy"]
        }
      },
    list_hooks: {
      input_fields: ->(object_definitions) {
        [
          {
            name: "site_id",
            label: "Site Name",
            optional: true,
            type: "string",
            control_type: "select",
            pick_list: "sites",
            toggle_hint: "Use Site Name",
            toggle_field: {
              name: "site_id",
              label: "Site ID",
              type: "string",
              optional: true,
              control_type: "text",
              toggle_hint: "Use Site ID"
              }
            }
          ]
        },

      execute: ->(connection, input) {
        if input["site_id"].blank?
          { hooks: get("https://api.netlify.com/api/v1/hooks") }
        else
          { hooks: get("https://api.netlify.com/api/v1/hooks?site_id=
              #{input["site_id"]}") }
        end
        },

      output_fields: ->(object_definitions) {
        [
          {
            name: "hook_types",
            type: "array",
            of: "object",
            properties: object_definitions["hook"]
            }
          ]
        }
      },
    list_hook_types: {
      input_fields: ->(object_definitions) {[]},

      execute: ->(connection, input) {
        { hook_types: get("https://api.netlify.com/api/v1/hooks/types") }
        },

      output_fields: ->(object_definitions) {
        [
          {
            name: "hook_types",
            type: "array",
            of: "object",
            properties: object_definitions["hook_type"]
            }
          ]
        }
      },
    delete_hook: {
      input_fields: ->(object_definitions) {
        [
          {
            name: "hook_id",
            label: "Hook ID",
            optional: false,
            type: "string",
            control_type: "text"
            }
          ]
        },

      execute: ->(connection, input) {
        delete("https://api.netlify.com/api/v1/hooks/#{input["hook_id"]}")
        },

      output_fields: ->(object_definitions) {[]}
      },
    add_hook: {
      input_fields: ->(object_definitions) {
        [
          {
            name: "site_id",
            label: "Site Name",
            optional: false,
            type: "string",
            control_type: "select",
            pick_list: "sites",
            toggle_hint: "Use Site Name",
            toggle_field: {
              name: "site_id",
              label: "Site ID",
              type: "string",
              optional: false,
              control_type: "text",
              toggle_hint: "Use Site ID"
              }
            },
          {
            name: "hook_type",
            label: "Hook type",
            control_type: "select",
            pick_list: "hook_types",
            optional: false
            },
          {
            name: "event_type",
            label: "Event type",
            control_type: "select",
            pick_list: "event_types",
            pick_list_params: { hook_type: "hook_type" },
            optional: false
            },
          {
            name: "url",
            label: "Url",
            control_type: "url",
            type: "string",
            optional: true
            },

          ]
        },
      execute: ->(connection, input) {
        post("https://api.netlify.com/api/v1/hooks").
          payload(
            site_id: input["site_id"],
            event: input["event_type"],
            type: input["hook_type"],
            data: {
              url: input["url"]
              }
            )
        },
      output_fields: ->(object_definitions) {[]}
      }
    },

  triggers: {
    new_event: {
      type: :paging_desc,

      input_fields: ->(object_definitions) {
        [
          {
            name: "site_id",
            label: "Site Name",
            optional: false,
            type: "string",
            control_type: "select",
            pick_list: "sites",
            toggle_hint: "Use Site Name",
            toggle_field: {
              name: "site_id",
              label: "Site ID",
              type: "string",
              optional: false,
              control_type: "text",
              toggle_hint: "Use Site ID"
              }
            },
          {
            name: "event_type",
            label: "Event type",
            control_type: "select",
            pick_list: "url_event_types",
            optional: false
            }
          ]
        },

      webhook_subscribe: ->(webhook_url, connection, input, recipe_id) {
        post("https://api.netlify.com/api/v1/hooks",
          site_id: input["site_id"],
          event: input["event_type"],
          type: "url",
          data: {
            url: webhook_url
            },
          form_id: nil
          )
        },

      webhook_notification: ->(input, payload) {
        payload
        },

      webhook_unsubscribe: ->(webhook) {
        delete("https://api.netlify.com/api/v1/hooks/#{webhook['id']}")
        },

      dedup: ->(message) {
        message["id"]
        },

      output_fields: ->(object_definitions){
        object_definitions["deploy"]
        }
      },
    new_site: {
      type: :paging_desc,

      input_fields: ->() {[]},

      poll: -> (connection, input, page_to_poll) {
        page = (page_to_poll==nil)? 1 : page_to_poll
        page_size = 100

        sites = get("https://api.netlify.com/api/v1/sites").
          params(page: page,
            per_page: page_size)

        new_page_to_poll = page + 1

        {
          events: sites,
          next_page: new_page_to_poll
          }
        },

      dedup: ->(site) {
        site["id"]
        },

      output_fields: ->(object_definitions) {
        object_definitions["site"]
        }
      },
    new_deploy_in_site: {
      type: :paging_desc,

      input_fields: ->() {
        [{
          name: "id",
          label: "Site Name",
          optional: false,
          type: "string",
          control_type: "select",
          pick_list: "sites",
          toggle_hint: "Use Site Name",
          toggle_field: {
            name: "id",
            label: "Site ID",
            type: "string",
            optional: false,
            control_type: "text",
            toggle_hint: "Use Site ID"
            }
          }]
        },

      poll: -> (connection, input, page_to_poll) {
        page = (page_to_poll==nil)? 1 : page_to_poll
        page_size = 100

        deploys = get("https://api.netlify.com/api/v1/sites/
          #{input["id"]}/deploys").
          params(page: page,
            per_page: page_size)

        new_page_to_poll = page + 1

        {
          events: deploys,
          next_page: new_page_to_poll
          }
        },

      dedup: ->(deploy) {
        deploy["id"]
        },

      output_fields: ->(object_definitions) {
        object_definitions["deploy"]
        }
      },
    new_form_submission: {
      type: :paging_desc,

      input_fields: ->() {[]},

      poll: -> (connection, input, page_to_poll) {
        page = (page_to_poll==nil)? 1 : page_to_poll
        page_size = 100

        submissions = get("https://api.netlify.com/api/v1/submissions").
          params(page: page,
            per_page: page_size)

        new_page_to_poll = page + 1

        {
          events: submissions,
          next_page: new_page_to_poll
          }
        },

      dedup: ->(submission) {
        submission["id"]
        },

      output_fields: ->(object_definitions) {
        object_definitions["submission"]
        }
      }
    },

  pick_lists: {
    sites: lambda do
      get("https://api.netlify.com/api/v1/sites").
        map { |site| [site["name"], site["id"]] }
    end,

    forms: lambda do
      get("https://api.netlify.com/api/v1/forms").
        map { |form| [form["name"], form["id"]] }
    end,

    hook_types: lambda do
      get("https://api.netlify.com/api/v1/hooks/types").
        map{ |ht| [ht["name"], ht["name"]] }
    end,
    
    event_types: ->(connection, hook_type:) {
      selected_hook_type = nil
      get("https://api.netlify.com/api/v1/hooks/types").each do |ht|
        if ht["name"]==hook_type
          selected_hook_type = ht
        end
      end
      selected_hook_type["events"].map{ |et| [et, et] }
      },

    url_event_types: lambda do
      selected_hook_type = nil
      get("https://api.netlify.com/api/v1/hooks/types").each do |ht|
        if ht["name"]=="url"
          selected_hook_type = ht
        end
      end
      selected_hook_type["events"].map{ |et| [et, et] }
    end
    }
  }
