terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "0.59.0"
    }
  }
}

provider "snowflake" {
  account = "zmyinqd-xk45569"
  username = "tf-snow"
  private_key_path = "./id_rsa_snowflake_demo"
  role = "ACCOUNTADMIN"
}

resource "snowflake_database" "db" {
  name = "ACCESS_CONTROL_TF_DB"
}

resource "snowflake_schema" "schema" {
  database   = snowflake_database.db.name
  name = "ACCESS_CONTROL_TF_DB.MANAGED_SCHEMA_TF"
  is_managed = true
}

###########################################
### CREATE ROLES #####

resource "snowflake_role" "s_full" {
  name    = "S_FULL_TF"
}
 
 resource "snowflake_role" "s_write" {
  name    = "S_WRITE_TF"
}

resource "snowflake_role" "s_read" {
  name    = "S_READ_TF"
}

resource "snowflake_role" "d_full" {
  name    = "D_FULL_TF"
}

resource "snowflake_role" "d_usage" {
  name    = "D_USAGE_TF"
}

resource "snowflake_role" "local_admin_role" {
  name    = "LOCAL_ADMIN_ROLE_TF"
}

###########################################
### GRANT PRIVILEGES #######

resource "snowflake_database_grant" "db_grant" {
  database_name = snowflake_database.db.name
  privilege = "USAGE"
  roles = [snowflake_role.s_full.name, snowflake_role.s_write.name, snowflake_role.s_read.name, 
          snowflake_role.d_usage.name]
}

resource "snowflake_schema_grant" "schema_grant_1" {
  database_name = snowflake_database.db.name
  schema_name = snowflake_schema.schema.name
  privilege = "USAGE"
  roles = [snowflake_role.s_full.name, snowflake_role.s_write.name, snowflake_role.s_read.name, 
          snowflake_role.d_usage.name]
  
}

resource "snowflake_schema_grant" "schema_grant_2" {
  database_name = snowflake_database.db.name
  schema_name = snowflake_schema.schema.name
  privilege = "MODIFY"
  roles = [snowflake_role.s_full.name, snowflake_role.s_write.name]
}

resource "snowflake_schema_grant" "schema_grant_3" {
  database_name = snowflake_database.db.name
  schema_name = snowflake_schema.schema.name
  privilege = "MONITOR"
  roles = [snowflake_role.s_full.name, snowflake_role.s_write.name]
}

resource "snowflake_schema_grant" "schema_grant_4" {
  database_name = snowflake_database.db.name
  schema_name = snowflake_schema.schema.name
  privilege = "CREATE TABLE"
  roles = [snowflake_role.s_full.name, snowflake_role.s_write.name]
}

resource "snowflake_schema_grant" "schema_grant_5" {
  database_name = snowflake_database.db.name
  schema_name = snowflake_schema.schema.name
  privilege = "CREATE EXTERNAL TABLE"
  roles = [snowflake_role.s_full.name, snowflake_role.s_write.name]
}

resource "snowflake_schema_grant" "schema_grant_6" {
  database_name = snowflake_database.db.name
  schema_name = snowflake_schema.schema.name
  privilege = "CREATE VIEW"
  roles = [snowflake_role.s_full.name, snowflake_role.s_write.name]
}

resource "snowflake_schema_grant" "schema_grant_7" {
  database_name = snowflake_database.db.name
  schema_name = snowflake_schema.schema.name
  privilege = "CREATE MATERIALIZED VIEW"
  roles = [snowflake_role.s_full.name, snowflake_role.s_write.name]
}

resource "snowflake_schema_grant" "schema_grant_8" {
  database_name = snowflake_database.db.name
  schema_name = snowflake_schema.schema.name
  privilege = "CREATE MASKING POLICY"
  roles = [snowflake_role.s_full.name]
}

resource "snowflake_schema_grant" "schema_grant_9" {
  database_name = snowflake_database.db.name
  schema_name = snowflake_schema.schema.name
  privilege = "CREATE SEQUENCE"
  roles = [snowflake_role.s_full.name, snowflake_role.s_write.name]
}

resource "snowflake_schema_grant" "schema_grant_10" {
  database_name = snowflake_database.db.name
  schema_name = snowflake_schema.schema.name
  privilege = "CREATE FUNCTION"
  roles = [snowflake_role.s_full.name, snowflake_role.s_write.name]
}

resource "snowflake_schema_grant" "schema_grant_11" {
  database_name = snowflake_database.db.name
  schema_name = snowflake_schema.schema.name
  privilege = "CREATE PROCEDURE"
  roles = [snowflake_role.s_full.name, snowflake_role.s_write.name]
}

resource "snowflake_schema_grant" "schema_grant_12" {
  database_name = snowflake_database.db.name
  schema_name = snowflake_schema.schema.name
  privilege = "CREATE FILE FORMAT"
  roles = [snowflake_role.s_full.name, snowflake_role.s_write.name]
}

resource "snowflake_schema_grant" "schema_grant_13" {
  database_name = snowflake_database.db.name
  schema_name = snowflake_schema.schema.name
  privilege = "CREATE STAGE"
  roles = [snowflake_role.s_full.name]
}

resource "snowflake_schema_grant" "schema_grant_14" {
  database_name = snowflake_database.db.name
  schema_name = snowflake_schema.schema.name
  privilege = "CREATE PIPE"
  roles = [snowflake_role.s_full.name]
}

resource "snowflake_schema_grant" "schema_grant_15" {
  database_name = snowflake_database.db.name
  schema_name = snowflake_schema.schema.name
  privilege = "CREATE STREAM"
  roles = [snowflake_role.s_full.name]
}

resource "snowflake_schema_grant" "schema_grant_16" {
  database_name = snowflake_database.db.name
  schema_name = snowflake_schema.schema.name
  privilege = "CREATE TASK"
  roles = [snowflake_role.s_full.name]
}

resource "snowflake_table_grant" "tab_grant_1" {
  database_name = snowflake_database.db.name
  schema_name = snowflake_schema.schema.name
  privilege = "SELECT"
  roles = [snowflake_role.s_full.name, snowflake_role.s_write.name, snowflake_role.s_read.name]
  on_future = true
}

resource "snowflake_table_grant" "tab_grant_2" {
  database_name = snowflake_database.db.name
  schema_name = snowflake_schema.schema.name
  privilege = "REFERENCES"
  roles = [snowflake_role.s_full.name, snowflake_role.s_write.name, snowflake_role.s_read.name]
  on_future = true
}

resource "snowflake_table_grant" "tab_grant_3" {
  database_name = snowflake_database.db.name
  schema_name = snowflake_schema.schema.name
  privilege = "INSERT"
  roles = [snowflake_role.s_full.name, snowflake_role.s_write.name]
  on_future = true
}

resource "snowflake_table_grant" "tab_grant_4" {
  database_name = snowflake_database.db.name
  schema_name = snowflake_schema.schema.name
  privilege = "UPDATE"
  roles = [snowflake_role.s_full.name, snowflake_role.s_write.name]
  on_future = true
}

resource "snowflake_table_grant" "tab_grant_5" {
  database_name = snowflake_database.db.name
  schema_name = snowflake_schema.schema.name
  privilege = "DELETE"
  roles = [snowflake_role.s_full.name, snowflake_role.s_write.name]
  on_future = true
}

resource "snowflake_table_grant" "tab_grant_6" {
  database_name = snowflake_database.db.name
  schema_name = snowflake_schema.schema.name
  privilege = "TRUNCATE"
  roles = [snowflake_role.s_full.name, snowflake_role.s_write.name]
  on_future = true
}

resource "snowflake_external_table_grant" "ex_tab_grant_1" {
  database_name = snowflake_database.db.name
  schema_name = snowflake_schema.schema.name
  privilege = "SELECT"
  roles = [snowflake_role.s_full.name, snowflake_role.s_write.name, snowflake_role.s_read.name]
  on_future = true
}

resource "snowflake_view_grant" "view_grant_1" {
  database_name = snowflake_database.db.name
  schema_name = snowflake_schema.schema.name
  privilege = "SELECT"
  roles = [snowflake_role.s_full.name, snowflake_role.s_write.name, snowflake_role.s_read.name]
  on_future = true
}

resource "snowflake_materialized_view_grant" "mat_view_grant_1" {
  database_name = snowflake_database.db.name
  schema_name = snowflake_schema.schema.name
  privilege = "SELECT"
  roles = [snowflake_role.s_full.name, snowflake_role.s_write.name, snowflake_role.s_read.name]
  on_future = true
}

resource "snowflake_stream_grant" "stream_grant_1" {
  database_name = snowflake_database.db.name
  schema_name = snowflake_schema.schema.name
  privilege = "SELECT"
  roles = [snowflake_role.s_full.name, snowflake_role.s_write.name]
  on_future = true
}

resource "snowflake_function_grant" "fun_grant_1" {
  database_name = snowflake_database.db.name
  schema_name = snowflake_schema.schema.name
  privilege = "USAGE"
  roles = [snowflake_role.s_full.name, snowflake_role.s_write.name, snowflake_role.s_read.name]
  on_future = true
}

resource "snowflake_procedure_grant" "proc_grant_1" {
  database_name = snowflake_database.db.name
  schema_name = snowflake_schema.schema.name
  privilege = "USAGE"
  roles = [snowflake_role.s_full.name, snowflake_role.s_write.name, snowflake_role.s_read.name]
  on_future = true
}

resource "snowflake_file_format_grant" "file_format_grant_1" {
  database_name = snowflake_database.db.name
  schema_name = snowflake_schema.schema.name
  privilege = "USAGE"
  roles = [snowflake_role.s_full.name, snowflake_role.s_write.name, snowflake_role.s_read.name]
  on_future = true
}

resource "snowflake_sequence_grant" "seq_grant_1" {
  database_name = snowflake_database.db.name
  schema_name = snowflake_schema.schema.name
  privilege = "USAGE"
  roles = [snowflake_role.s_full.name, snowflake_role.s_write.name, snowflake_role.s_read.name]
  on_future = true
}

resource "snowflake_stage_grant" "stage_grant_1" {
  database_name = snowflake_database.db.name
  schema_name = snowflake_schema.schema.name
  privilege = "USAGE"
  roles = [snowflake_role.s_full.name, snowflake_role.s_write.name, snowflake_role.s_read.name]
  on_future = true
}

resource "snowflake_stage_grant" "stage_grant_2" {
  database_name = snowflake_database.db.name
  schema_name = snowflake_schema.schema.name
  privilege = "READ"
  roles = [snowflake_role.s_full.name, snowflake_role.s_write.name]
  on_future = true
}

resource "snowflake_stage_grant" "stage_grant_3" {
  database_name = snowflake_database.db.name
  schema_name = snowflake_schema.schema.name
  privilege = "WRITE"
  roles = [snowflake_role.s_full.name, snowflake_role.s_write.name]
  on_future = true
}

resource "snowflake_database_grant" "schema_grant_2" {
  database_name = snowflake_database.db.name
  privilege = "CREATE SCHEMA"
  roles = [snowflake_role.d_full.name]
}

##### ROLE GRANTS ######

resource "snowflake_role_ownership_grant" "role_owner_grant_1" {
  on_role_name = snowflake_role.s_full.name
  to_role_name = snowflake_role.local_admin_role.name
}

resource "snowflake_role_ownership_grant" "role_owner_grant_2" {
  on_role_name = snowflake_role.s_read.name
  to_role_name = snowflake_role.local_admin_role.name
}

resource "snowflake_role_ownership_grant" "role_owner_grant_3" {
  on_role_name = snowflake_role.s_write.name
  to_role_name = snowflake_role.local_admin_role.name
}

resource "snowflake_role_ownership_grant" "role_owner_grant_4" {
  on_role_name = snowflake_role.d_full.name
  to_role_name = snowflake_role.local_admin_role.name
}

resource "snowflake_role_ownership_grant" "role_owner_grant_5" {
  on_role_name = snowflake_role.d_usage.name
  to_role_name = snowflake_role.local_admin_role.name
}

resource "snowflake_role_grants" "role_grant_1" {
  role_name = snowflake_role.s_full.name
  roles = [snowflake_role.d_full.name]
}

resource "snowflake_role_grants" "role_grant_2" {
  role_name = snowflake_role.s_full.name
  roles = [snowflake_role.local_admin_role.name]
}

resource "snowflake_role_grants" "role_grant_3" {
  role_name = snowflake_role.s_read.name
  roles = [snowflake_role.local_admin_role.name]
}

resource "snowflake_role_grants" "role_grant_4" {
  role_name = snowflake_role.s_write.name
  roles = [snowflake_role.local_admin_role.name]
}

resource "snowflake_role_grants" "role_grant_5" {
  role_name = snowflake_role.d_usage.name
  roles = [snowflake_role.local_admin_role.name]
}

resource "snowflake_role_grants" "role_grant_6" {
  role_name = snowflake_role.d_full.name
  roles = [snowflake_role.local_admin_role.name]
}

resource "snowflake_account_grant" "acc_grant_1" {
  roles = [ snowflake_role.local_admin_role.name ]
  privilege = "CREATE ROLE"
}

resource "snowflake_account_grant" "acc_grant_2" {
  roles = [ snowflake_role.local_admin_role.name ]
  privilege = "CREATE USER"
}

##### CREATE USER ######
resource "snowflake_user" "create_admin" {
  name = "LOCAL_ADMIN_TF"
  login_name = "admin_tf"
  password = "admin_tf"
  default_role = snowflake_role.local_admin_role.name
  must_change_password = false
}

resource "snowflake_role_grants" "role_to_user_1" {
  role_name = snowflake_role.local_admin_role.name
  users = [snowflake_user.create_admin.name]
}