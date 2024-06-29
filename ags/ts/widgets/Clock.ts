const date = Variable("", {
  poll: [1000, "date +%R"],
});

const Clock = () => Widget.Label({ className: "clock", label: date.bind() });

export default Clock;
