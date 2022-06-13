/**
 * My worker here is based heavily on the example in https://developers.cloudflare.com/r2/get-started/
 * For an actual verification setup I would build logic to use HMAC with an expiry, but for this simple case
 * a pre-shared secret should be fine
 */
export interface Env {
  QUERY_SECRET: string;
  R2_BUCKET: R2Bucket;
}

export default {
  async fetch(
    request: Request,
    env: Env,
    ctx: ExecutionContext
  ): Promise<Response> {
    const url = new URL(request.url);
    const key = url.pathname.slice(1);

    // 1 year
    const expiration = 31536000

    if (url.searchParams.get('verify') != env.QUERY_SECRET) {
      return new Response("Not Authorized", { status: 401 })
    }

    switch (request.method) {
      case 'GET':
        const object = await env.R2_BUCKET.get(key);

        if (!object || !object.body) {
          return new Response('Object Not Found', { status: 404 });
        }

        const headers = new Headers();
        object.writeHttpMetadata(headers);
        headers.set('etag', object.httpEtag);
        headers.set('Cache-Control', "public, max-age=" + expiration);


        return new Response(object.body, {
          headers,
        });
      default:
        return new Response('Method Not Allowed', {
          status: 405,
          headers: {
            Allow: 'GET',
          },
        });
    }
  },
};
