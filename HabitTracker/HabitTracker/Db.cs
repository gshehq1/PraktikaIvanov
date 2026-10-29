#nullable disable
using System;
using System.Data;
using Npgsql;

namespace HabitTracker
{

    public static class Db
    {
        public const string ConnectionString =
            "Host=localhost;Port=5432;Database=PraktikaIvanov;Username=IvanovN;Password=Hshshshs1";
        // =====================================================================

        public static NpgsqlConnection GetConnection()
        {
            return new NpgsqlConnection(ConnectionString);
        }

        public static NpgsqlParameter P(string name, object value)
        {
            return new NpgsqlParameter(name, value ?? DBNull.Value);
        }
        public static DataTable Query(string sql, params NpgsqlParameter[] ps)
        {
            using (var conn = GetConnection())
            using (var cmd = new NpgsqlCommand(sql, conn))
            {
                if (ps != null && ps.Length > 0) cmd.Parameters.AddRange(ps);
                var table = new DataTable();
                using (var adapter = new NpgsqlDataAdapter(cmd))
                {
                    adapter.Fill(table);
                }
                return table;
            }
        }


        public static int Execute(string sql, params NpgsqlParameter[] ps)
        {
            using (var conn = GetConnection())
            using (var cmd = new NpgsqlCommand(sql, conn))
            {
                if (ps != null && ps.Length > 0) cmd.Parameters.AddRange(ps);
                conn.Open();
                return cmd.ExecuteNonQuery();
            }
        }


        public static object Scalar(string sql, params NpgsqlParameter[] ps)
        {
            using (var conn = GetConnection())
            using (var cmd = new NpgsqlCommand(sql, conn))
            {
                if (ps != null && ps.Length > 0) cmd.Parameters.AddRange(ps);
                conn.Open();
                return cmd.ExecuteScalar();
            }
        }


        public static DataTable Lookup(string table, string idColumn, string nameColumn)
        {
            return Query("SELECT " + idColumn + " AS id, CAST(" + nameColumn + " AS text) AS name FROM "
                         + table + " ORDER BY " + nameColumn);
        }

        public static string EscapeLike(string text)
        {
            return text.Replace("\\", "\\\\").Replace("%", "\\%").Replace("_", "\\_");
        }

        public static void EnsureStatuses()
        {
            Execute("INSERT INTO request_statuses (status_name) SELECT @s " +
                    "WHERE NOT EXISTS (SELECT 1 FROM request_statuses WHERE status_name = @s)",
                    P("s", Statuses.Received));
        }
    }
}
