exports.handler = (event, context, callback) => {
  console.log(event);

  callback(null, "Hello from Lambda");
};
