describe("Dynamic form", function() {
  it("appends user email form field on click", function() {

  });
});

  describe("buildEmailForm", function() {
    it('should return a form with a specified count', function() {
      expect(buildEmailForm(0)).toEqual("<input name='users[0]' type='text' placeholder='Email'/>")
      expect(buildEmailForm(5)).toEqual("<input name='users[5]' type='text' placeholder='Email'/>")
    }
  }
});
