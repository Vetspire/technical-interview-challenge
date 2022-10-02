defmodule ServerWeb.Schema.S3TypesTest do
  use ServerWeb.ConnCase, async: true

  import Mox

  setup :verify_on_exit!

  @s3_presigned_url_query """
  query s3_presigned_url($filename: String!) {
    s3_presigned_url(filename: $filename) {
      url
      fields {
        key
        value
      }
    }
  }
  """

  describe "query s3_presigned_url" do
    test "success: returns url and fields", %{conn: conn} do
      filename = "cavapoo.png"
      expected_presigned_url = "https://bucket.s3.region.amazonaws.com"

      expect(Server.MockS3, :presigned_post, fn "dogs/cavapoo.png", _opts ->
        %{
          fields: %{
            "Policy" => "value",
            "X-Amz-Algorithm" => "value",
            "X-Amz-Credential" => "value",
            "X-Amz-Date" => "value",
            "X-Amz-Signature" => "value",
            "key" => "dogs/cavapoo.png"
          },
          url: expected_presigned_url
        }
      end)

      params = %{
        "query" => @s3_presigned_url_query,
        "variables" => %{filename: "cavapoo.png"}
      }

      %{
        "data" => %{
          "s3_presigned_url" => %{
            "fields" => fields,
            "url" => url
          }
        }
      } = conn |> post("/graphql", params) |> json_response(200)

      assert url == expected_presigned_url

      assert [
               %{"key" => "Policy", "value" => "value"},
               %{"key" => "X-Amz-Algorithm", "value" => "value"},
               %{"key" => "X-Amz-Credential", "value" => "value"},
               %{"key" => "X-Amz-Date", "value" => "value"},
               %{"key" => "X-Amz-Signature", "value" => "value"},
               %{"key" => "key", "value" => "dogs/cavapoo.png"}
             ] == fields
    end
  end
end
