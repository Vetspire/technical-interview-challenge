const parseResponse = <T>(resp: Response): Promise<T> => {
  if (!resp.ok) {
    return Promise.reject(resp);
  }
  return resp.json();
};

export const get = <T>(path: string): Promise<T> =>
  window.fetch(path).then((resp) => parseResponse(resp));

export const post = <B extends BodyInit, T>(
  path: string,
  body: B,
): Promise<T> =>
  window
    .fetch(path, { method: "POST", body })
    .then((resp) => parseResponse(resp));
